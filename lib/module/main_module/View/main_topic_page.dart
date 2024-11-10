import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:splash/component/loading_indicator.dart';

import 'package:splash/component/utils/const_var.dart';
import 'package:splash/module/image_module/View/image_detail.dart';
import 'package:splash/module/main_module/Controller/main_topic_controller.dart';
import 'package:splash/module/main_module/Model/topic_model.dart';
import 'package:splash/module/main_module/View/main_cell.dart';

class MainTopicPage extends StatefulWidget {
  final TopicModel topicM;

  const MainTopicPage({super.key, required this.topicM});

  @override
  State<MainTopicPage> createState() => _MainTopicPageState();
}

class _MainTopicPageState extends State<MainTopicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持页面状态

  late MainTopicListController topicCtrl;

  @override
  void initState() {
    // TODO: implement initState
    topicCtrl = Get.put(MainTopicListController(widget.topicM.id),
        tag: widget.topicM.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if (topicCtrl.isLoading.value) {
        return Column(
          children: [
            _buildPlaceHolderWidget(),
            const Expanded(
              child: Center(
                child: LoadingIndicator(
                  inputColor: Colors.amber,
                ),
              ),
            )
          ],
        );
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: topicCtrl.imageInfos.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildPlaceHolderWidget();
          }
          int actualIndex = index - 1;
          return GestureDetector(
            onTap: () {
              Get.to(() => ImageDetailPage(
                  imageInfo: topicCtrl.imageInfos[actualIndex]));
            },
            child:
                MainPagePhotoCell(imageInfo: topicCtrl.imageInfos[actualIndex]),
          );
        },
      );
    });
  }

  Widget _buildPlaceHolderWidget() {
    var imageURL;
    if (topicCtrl.imageInfos.isEmpty == false) {
      imageURL = topicCtrl.imageInfos[0].urls?.regular;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: double.infinity,
          maxHeight: MediaQuery.of(context).padding.top + MainPageTopGap * 3),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: getGlobalBackGroundColor()),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: imageURL != null
                    ? CachedNetworkImage(
                        imageUrl: imageURL ?? "",
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
                      )
                    : Container()),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 文本左对齐
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    widget.topicM.title,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.topicM.description,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
