import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:splash/component/utils/const_var.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/image_module/Controller/image_detail_controller.dart';
import 'package:splash/module/image_module/View/image_exif.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({super.key, required this.imageInfo});
  final UnSplashImageInfo imageInfo;
  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  late PhotoViewController _photoViewController;
  bool _isImageScaled = false;
  bool _isPannelHidden = false;
  double? photoViewInitialScale;
  late ImageDetailController _imageController;
  @override
  void initState() {
    super.initState();
    _imageController = Get.put<ImageDetailController>(
        ImageDetailController(widget.imageInfo.id),
        tag: widget.imageInfo.id);
    _photoViewController = PhotoViewController()
      ..outputStateStream.listen((state) {
        setState(() {
          _isImageScaled = state.scale != null && state.scale! > 1.0;
        });
      });
  }

  @override
  void dispose() {
    _photoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              if (!_isImageScaled) {
                setState(() {
                  _isPannelHidden = !_isPannelHidden;
                });
              }
            },
            child: Stack(
              children: [
                PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                        widget.imageInfo.urls!.regular),
                    controller: _photoViewController,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                    backgroundDecoration: BoxDecoration(
                      color: getGlobalBackGroundColor(),
                    )),
                AnimatedOpacity(
                  opacity: _isPannelHidden ? 0 : 1,
                  duration: const Duration(milliseconds: 150),
                  child: IgnorePointer(
                    ignoring: _isPannelHidden == true,
                    child: Stack(children: [
                      //Pannel
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: generateImageDetailWidget()),
                                SafeArea(child: Container())
                              ]),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10.0),
                                  fillColor: Colors.black.withOpacity(0.6),
                                  child: const Icon(
                                      size: 30,
                                      Icons.favorite,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10.0),
                                  fillColor: Colors.black.withOpacity(0.6),
                                  child: const Icon(
                                      size: 30, Icons.add, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(10.0),
                                  fillColor: Colors.black.withOpacity(0.6),
                                  child: const Icon(
                                      size: 35,
                                      Icons.download_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SafeArea(child: Container())
                            ],
                          )
                        ],
                      ),

                      SafeArea(
                        child: Container(
                          height: kToolbarHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Get.back(),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    widget.imageInfo.user.name,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _onShare(
                                    context,
                                    Uri.parse(
                                        widget.imageInfo.links?.html ?? "")),
                                icon: const Icon(
                                  Icons.ios_share,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            )));
  }

  void _onShare(BuildContext context, Uri? uri) async {
    log("Will Share HTML URL:$uri");
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    if (uri != null) {
      await Share.shareUri(
        uri,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }

  Widget generateImageDetailWidget() {
    return Obx(() {
      if (_imageController.detailImageInfo.value != null) {
        return GestureDetector(
          onTap: () {
            //Show Image Info
            showModalBottomSheet(
              scrollControlDisabledMaxHeightRatio: 0.95,
              context: context,
              backgroundColor: Colors.black.withOpacity(0.9),
              builder: (context) {
                return ImageDetailExifPage(
                    imageInfo: _imageController.detailImageInfo.value!);
              },
            );
          },
          child: const Icon(
            Icons.info,
            color: Colors.white,
          ),
        );
      }
      return Container();
    });
  }
}
