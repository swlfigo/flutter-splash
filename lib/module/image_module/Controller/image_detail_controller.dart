import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:splash/component/eventbus/event.dart';
import 'package:splash/component/eventbus/eventbus.dart';

import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/image_module/Controller/image_detail_state.dart';
import 'package:splash/module/user/Service/user_service.dart';
import 'package:splash/net/api.dart';

class ImageDetailController extends GetxController {
  // 将状态分离到单独的类中
  final state = ImageDetailState();

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

  void toggleLikeState(bool islikePhoto) async {
    var userService = Get.find<UserService>();
    if (!userService.isLogined.value) {
      return;
    }
    state.likeRequesting.value = true;
    try {
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/photos/$imagePicID/like',
          null,
          {"need_auth": true},
          Options(method: islikePhoto ? 'POST' : 'DELETE'));
      if (res != null && res.data != null) {
        var detailInfo = UnSplashImageInfo.fromJson(
            (res.data as Map<String, dynamic>)['photo']);
        //Post Notification
        EventBus().fire(ImageLikeEvent(
            detailInfo.id,
            detailInfo.likeByUser == null
                ? false
                : (detailInfo.likeByUser! ? true : false)));
      }
    } catch (e) {
      log("Toggle Like State Error,Image ID:$imagePicID,Error:$e");
    } finally {
      state.likeRequesting.value = false;
      update();
    }
  }
}
