import 'package:flutter/material.dart';
import 'package:splash/model/unsplash_image_model.dart';

class MainPagePhotoCell extends StatelessWidget {
  final UnSplashImageInfo imageInfo;
  const MainPagePhotoCell({super.key, required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.network(
        imageInfo.urls?.small ?? "",
        fit: BoxFit.cover,
      ),
      Positioned(
          bottom: 10, // 距离底部的距离
          left: 15, // 距离左边的距离
          child: Text(
            imageInfo.user?.username ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )),
    ]);
  }
}
