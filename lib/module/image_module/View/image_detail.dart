import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:splash/component/utils/const_var.dart';
import 'package:splash/model/unsplash_image_model.dart';

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
  @override
  void initState() {
    super.initState();
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
                Opacity(
                  opacity: _isPannelHidden ? 0 : 1,
                  child: Stack(children: [
                    //Pannel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            const SizedBox(width: 48),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            )));
  }
}
