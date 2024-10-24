import 'dart:ffi';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:splash/component/home_cell.dart';
import 'package:splash/component/loading_indicator.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/search_module/Controller/search_controller.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';
import 'package:splash/module/search_module/Model/users.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态

  final TextEditingController textEditingController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  final SearchPhotoController searchCtrl = Get.put(SearchPhotoController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("Search Page Build");
    return Scaffold(
        backgroundColor: HexColor("111111"),
        appBar: AppBar(
          backgroundColor: HexColor("111111"),
          title: _buildTitleSearchBar(),
          scrolledUnderElevation: 0,
        ),
        body: Obx(() {
          if (searchCtrl.selectedSegementIndex.value == -1) {
            return const Center(
              child: Text("Try Searching Somethings"),
            );
          }

          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 30),
                  child: CustomSlidingSegmentedControl(
                    children: const <int, Widget>{
                      0: Text(
                        "Photos",
                        style: TextStyle(color: Colors.white),
                      ),
                      1: Text("Collections"),
                      2: Text("Users"),
                    },
                    thumbDecoration: BoxDecoration(
                      color: HexColor("636368"),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("29292c"),
                    ),
                    initialValue: searchCtrl.selectedSegementIndex.value,
                    onValueChanged: (index) {
                      print("SegmenControl Selected Index: $index");
                      searchCtrl.onSegmentChanged(index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: _buildList(),
              )
            ],
          );
        }));
  }

  Widget _buildList() {
    if (searchCtrl.isLoading.value == true) {
      return const LoadingIndicator();
    }
    if (searchCtrl.selectedSegementIndex.value == 0) {
      return _buildPhotosList();
    } else if (searchCtrl.selectedSegementIndex.value == 1) {
      return _buildCollectionList();
    } else if (searchCtrl.selectedSegementIndex.value == 2) {
      return _buildUsersList();
    }
    return Container();
  }

  Widget _buildPhotosList() {
    if (searchCtrl.searchPhotosResults.isEmpty) {
      return _buildNoResult();
    }
    return ListView.builder(
      itemCount: searchCtrl.searchPhotosResults.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          searchCtrl.searchPhotosResults[index].urls?.small ?? "",
        );
      },
    );
  }

  Widget _buildCollectionList() {
    if (searchCtrl.searchCollectionResults.isEmpty) {
      return _buildNoResult();
    }

    return ListView.builder(
      itemCount: searchCtrl.searchCollectionResults.length,
      itemBuilder: (BuildContext context, int index) {
        UnsplashCollectionInfo collectionInfo =
            searchCtrl.searchCollectionResults[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("1c1c1c"),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1),
                    itemCount: collectionInfo.previewPhotos == null
                        ? 0
                        : collectionInfo.previewPhotos!.length > 3
                            ? 3
                            : collectionInfo.previewPhotos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final imageURL =
                          collectionInfo.previewPhotos?[index].urls?.thumb;
                      if (imageURL == null) {
                        return Container();
                      }
                      return Image.network(
                        imageURL,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8, bottom: 10),
                    child: Text(
                      collectionInfo.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${collectionInfo.totalPhotos} photos · Curated by ${collectionInfo.user.name}'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUsersList() {
    if (searchCtrl.searchUsersResults.isEmpty) {
      return _buildNoResult();
    }
    return ListView.builder(
      itemCount: searchCtrl.searchUsersResults.length,
      itemBuilder: (BuildContext context, int index) {
        UnsplashUserInfo userInfo = searchCtrl.searchUsersResults[index];

        return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        width: 60,
                        height: 60,
                        userInfo.profileImage.medium,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userInfo.name),
                          Text(userInfo.username)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSearchBar() {
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 40),
            child: TextField(
              onSubmitted: (value) {
                searchCtrl.onSearchTextChanged(value);
              },
              controller: textEditingController,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: HexColor("29292b"),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Search photos,collections,users",
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  hintStyle: TextStyle(color: Colors.grey[400])),
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        OutlinedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.black),
            onPressed: () {
              print("Press ElevatedButton");
              searchFocusNode.unfocus();
              searchCtrl.onSearchTextChanged(textEditingController.text);
            },
            child: const Text("Search"))
      ],
    );
  }

  Widget _buildNoResult() {
    return const Center(
      child: Text("No Result"),
    );
  }
}
