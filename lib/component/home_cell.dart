import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:splash/model/unsplash_image_model.dart';

class HomeUnsplashImageInfoCell extends StatelessWidget {
  final UnSplashImageInfo uImageInfo;
  const HomeUnsplashImageInfoCell({super.key, required this.uImageInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeCellImageWidgetInfo(imageInfo: uImageInfo),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  uImageInfo.altDescription,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  // textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          imageUrl: uImageInfo.user.profileImage.small,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      uImageInfo.user.username,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          uImageInfo.likes.toString(),
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        const SizedBox(width: 5),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCellImageWidgetInfo extends StatelessWidget {
  final UnSplashImageInfo imageInfo;
  const HomeCellImageWidgetInfo({super.key, required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: imageInfo.width > imageInfo.height ? 16 / 9 : 9 / 16,
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.cover,
          child: CachedNetworkImage(
            imageUrl: imageInfo.urls?.small ?? "",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}
