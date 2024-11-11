import 'dart:developer';

import 'package:get/get.dart';

import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/net/api.dart';

class ImageDetailController extends GetxController {
  final String imagePicID;

  ImageDetailController(this.imagePicID);

  Rx<UnSplashImageInfo?> detailImageInfo = Rx<UnSplashImageInfo?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchImageInfo();
  }

  void fetchImageInfo() async {
    try {
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/photos/$imagePicID', null, null, null);
      if (res != null && res.data != null) {
        detailImageInfo.value =
            UnSplashImageInfo.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      log("Fetch Image Detail Error,ID:$imagePicID,Error:$e");
    }
  }
}
