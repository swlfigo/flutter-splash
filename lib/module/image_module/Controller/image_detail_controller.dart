import 'dart:developer';

import 'package:get/get.dart';

import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/net/api.dart';

class ImageDetailController extends GetxController {
  final String imagePicID;

  ImageDetailController(this.imagePicID);

  Rx<UnSplashImageInfo?> detailImageInfo = Rx<UnSplashImageInfo?>(null);

  void fetchImageInfo(
      void Function(UnSplashImageInfo imageDetailInfo)? callback) async {
    try {
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/photos/$imagePicID',
          null,
          {"need_auth": true},
          null);
      if (res != null && res.data != null) {
        var detailInfo =
            UnSplashImageInfo.fromJson(res.data as Map<String, dynamic>);
        detailImageInfo.value = detailInfo;
        if (callback != null) {
          callback(detailInfo);
        }
      }
    } catch (e) {
      log("Fetch Image Detail Error,ID:$imagePicID,Error:$e");
    }
  }
}
