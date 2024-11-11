import 'package:flutter/material.dart';
import 'package:splash/model/unsplash_image_model.dart';

class ImageDetailExifPage extends StatelessWidget {
  final UnSplashImageInfo imageInfo;
  const ImageDetailExifPage({super.key, required this.imageInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TopBar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Info",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 48,
            )
          ],
        ),

        //Geo

        //Camera
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Camera",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              //Camera Info;
              Container(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height * 0.7, // 最大高度为屏幕70%
                  ),
                  child: _buildCamearaInfo())
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCamearaInfo() {
    var dString = DateTime.parse(imageInfo.createdAt ?? "");
    var imageInfoMap = [
      {"Make": imageInfo.exif?.make},
      {"Focal Length (mm)": imageInfo.exif?.focalLength ?? ""},
      {"Model": imageInfo.exif?.model},
      {"ISO": imageInfo.exif?.iso.toString()},
      {"Shutter Speed (s)": imageInfo.exif?.exposureTime},
      {"Dimensions": "${imageInfo.width} x ${imageInfo.height}"},
      {"Aperture (f)": imageInfo.exif?.aperture ?? ""},
      {"Published": "${dString.month} ${dString.day},${dString.year}"},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1, // 减小间距
        mainAxisSpacing: 1, // 减小间距
        childAspectRatio: 4, // 增大这个值会使item更扁平
      ),
      itemCount: imageInfoMap.length,
      itemBuilder: (BuildContext context, int index) {
        final item = imageInfoMap[index] as Map<String, dynamic>;
        final key = item.keys.first;
        final value = item.values.first;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(key), Text(value)],
        );
      },
    );
  }
}
