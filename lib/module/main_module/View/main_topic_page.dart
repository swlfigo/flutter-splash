import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash/component/home_cell.dart';
import 'package:splash/component/loading_indicator.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/component/utils/const_var.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/Model/topic_model.dart';
import 'package:splash/module/main_module/View/main_cell.dart';
import 'package:splash/net/api.dart';

class MainTopicPage extends StatefulWidget {
  final TopicModel topic;

  const MainTopicPage({super.key, required this.topic});

  @override
  State<MainTopicPage> createState() => _MainTopicPageState();
}

class _MainTopicPageState extends State<MainTopicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态

  Future<List<UnSplashImageInfo>?> fetchTopicPhotos() async {
    var res = await httpManager.netFetch(
        'https://api.unsplash.com/topics/${widget.topic.id}/photos',
        null,
        null,
        null);
    if (res != null && res.data != null) {
      var images = (res.data as List<dynamic>)
          .map((item) =>
              UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
          .toList();
      imageInfos.assignAll(images);
    }
    return null;
  }

  List<UnSplashImageInfo> imageInfos = [];
  Future? fetchTopicPhotosFuture;

  @override
  void initState() {
    // TODO: implement initState
    fetchTopicPhotosFuture = fetchTopicPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        initialData: const [],
        future: fetchTopicPhotosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          }
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: imageInfos.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Builder(builder: (BuildContext context) {
                    var imageURL;
                    if (imageInfos.isEmpty == false) {
                      imageURL = imageInfos[0].urls?.regular;
                    }

                    return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: double.infinity,
                          maxHeight: MediaQuery.of(context).padding.top +
                              MainPageTopGap * 3),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(color: HexColor("111111")),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.network(
                                imageURL ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: Container(
                                  color:
                                      Colors.black.withOpacity(0.6), // 添加半透明遮罩
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                }

                int actualIndex = index - 1;
                return MainPagePhotoCell(imageInfo: imageInfos[actualIndex]);
              });
        });
  }
}
