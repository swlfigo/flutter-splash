import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:splash/component/placeholder/placeholder.dart';
import 'package:splash/component/segment_control/segement_control.dart';
import 'package:splash/component/user_collection/user_collection.dart';
import 'package:splash/component/utils/const_var.dart';
import 'package:splash/module/main_module/View/main_cell.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';
import 'package:splash/module/user/Controller/user_controller.dart';
import 'package:splash/module/user/Service/user_service.dart';
import 'package:splash/module/user/View/self_user_login_page.dart';

class UserPage extends StatefulWidget {
  final String? userName;
  final String? userID;

  //Is User Page In Main Page
  final bool isMainPageUserModule;
  const UserPage(
      {super.key,
      this.userName,
      this.userID,
      required this.isMainPageUserModule});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  double _titleOpacity = 0.0;
  final ScrollController _scrollController = ScrollController();
  @override
  bool get wantKeepAlive {
    if (widget.isMainPageUserModule) {
      //首页跳转的个人页面保持
      return true;
    }
    return false;
  }

  late UserController _userCtrl;

  final UserService _userService = Get.find<UserService>();

  final double headerHeight = 120.0;

  void _onScroll() {
    // 计算标题透明度
    final double offset = _scrollController.offset;
    final double opacity = (offset / headerHeight).clamp(0.0, 1.0);
    if (opacity != _titleOpacity) {
      setState(() {
        _titleOpacity = opacity;
      });
    }
  }

  @override
  void initState() {
    _userCtrl = Get.put<UserController>(UserController(),
        tag: widget.isMainPageUserModule
            ? "main_module_user_ctrl"
            : widget.userID);
    _scrollController.addListener(_onScroll);
    if (widget.isMainPageUserModule) {
      _userCtrl.userInfo.value = _userService.userInfo.value;
      // 监听登录状态
      ever(_userService.isLogined, (_) {
        if (_userService.isLogined.value) {
          //Set User ID;Fetch UserInfo

          _userCtrl.setUpUserID(_userService.userAuthInfo.value?.userID);
        } else {
          //Clean User Info
          _userCtrl.userInfo.value = null;
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isMainPageUserModule) {
      super.build(context);
    }
    return Obx(() {
      if (widget.isMainPageUserModule == false) {
        return _buildLoginedWidget();
      }
      if (_userService.isLogined.value) {
        return _buildLoginedWidget();
      }
      return _buildUnLoginWidget();
    });
  }

  Widget _buildLoginedWidget() {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(color: getGlobalBackGroundColor()),
        child: CustomScrollView(
          // 允许在内容不足时反向滚动
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              scrolledUnderElevation: 0,
              backgroundColor: getGlobalBackGroundColor(),
              expandedHeight: 0,
              toolbarHeight: 50,
              floating: true,
              pinned: true,
              flexibleSpace: Container(),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.bottomLeft,
                height: headerHeight,
                decoration: BoxDecoration(color: getGlobalBackGroundColor()),
                child: Obx(() {
                  if (_userService.isLogined.value &&
                      _userService.userInfo.value != null) {
                    return Opacity(
                      opacity: 1 - _titleOpacity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60)),
                              child: CachedNetworkImage(
                                  width: 60,
                                  height: 60,
                                  imageUrl: _userService
                                      .userInfo.value!.profileImage.medium),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                _userService.userInfo.value!.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    minHeight: 60,
                    maxHeight: 60,
                    child: Container(
                      color: getGlobalBackGroundColor(),
                      alignment: Alignment.center,
                      child: ComponentSegmentControl(
                        onChange: onSegmentControlValueChange,
                        initialIndex: _userCtrl.selectedSegementIndex.value,
                        segmentTitle: const {
                          0: Text(
                            "Photos",
                            style: TextStyle(color: Colors.white),
                          ),
                          1: Text("Likes"),
                          2: Text("Collections"),
                        },
                      ),
                    ))),
            _buildDataList(),
          ],
        ),
      ),
      //TopBar
      _buildTopBar(),
    ]);
  }

  Widget _buildUnLoginWidget() {
    return const SelfUserLoginPage();
  }

  void onSegmentControlValueChange(int index) {
    _userCtrl.onSegmentChanged(index);
  }

  Widget _buildDataList() {
    return Obx(() {
      if (_userCtrl.selectedSegementIndex.value == 0) {
        if (_userCtrl.userPhotos.isEmpty) {
          return _buildPlaceHolderWidget('No Photos');
        }
        return SliverList.builder(
            itemBuilder: (context, index) {
              return MainPagePhotoCell(imageInfo: _userCtrl.userPhotos[index]);
            },
            itemCount: _userCtrl.userPhotos.length);
      } else if (_userCtrl.selectedSegementIndex.value == 1) {
        if (_userCtrl.userLikes.isEmpty) {
          return _buildPlaceHolderWidget('No Likes');
        }
        return SliverList.builder(
            itemBuilder: (context, index) {
              return MainPagePhotoCell(imageInfo: _userCtrl.userLikes[index]);
            },
            itemCount: _userCtrl.userLikes.length);
      } else if (_userCtrl.selectedSegementIndex.value == 2) {
        if (_userCtrl.userCollections.isEmpty) {
          return _buildPlaceHolderWidget('No Collections');
        }
        return SliverList.builder(
            itemBuilder: (context, index) {
              UnsplashCollectionInfo collectionInfo =
                  _userCtrl.userCollections[index];

              return UserCollectionWidget(collectionInfo: collectionInfo);
            },
            itemCount: _userCtrl.userCollections.length);
      }
      return Container();
    });
  }

  SliverFillRemaining _buildPlaceHolderWidget(String placeholderText) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 120,
              height: 120,
              child: PlaceHolderWidget(imagePath: 'assets/nophotos.png')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(placeholderText),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: MediaQuery.of(context).padding.top + 30,
      child: Stack(
        children: [
          Opacity(
            opacity: _titleOpacity,
            child: Container(
                margin: const EdgeInsets.only(bottom: 0),
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  if (_userService.userInfo.value != null) {
                    return Text(
                      _userService.userInfo.value!.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    );
                  }
                  return Container();
                })),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.stacked_line_chart,
                  color: Colors.white,
                ),
                Builder(builder: (context) {
                  if (widget.isMainPageUserModule) {
                    return GestureDetector(
                      onTap: () {
                        //Logout
                        _userService.logout();
                        _userCtrl.logout();
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
