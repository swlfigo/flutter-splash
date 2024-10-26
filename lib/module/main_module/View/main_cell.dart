import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:splash/component/utils/colors_ext.dart';
import 'package:splash/model/unsplash_image_model.dart';

class MainPagePhotoCell extends StatelessWidget {
  final UnSplashImageInfo imageInfo;
  const MainPagePhotoCell({super.key, required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CachedNetworkImage(
        imageUrl: imageInfo.urls?.small ?? "",
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return ColoredBox(
              color: imageInfo.color != null
                  ? HexColor(imageInfo.color!)
                  : HexColor("111111"));
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
      ),
      Positioned(
          bottom: 10, // 距离底部的距离
          left: 15, // 距离左边的距离
          child: Text(
            imageInfo.user.username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )),
    ]);
  }
}
