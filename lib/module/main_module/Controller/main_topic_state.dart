import 'package:get/get.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/user/Service/user_service.dart';

class MainTopicState {
  final RxList imageInfos = RxList<UnSplashImageInfo>([]);
  final RxBool isLoading = false.obs;
  final UserService _userService = Get.find<UserService>();
  MainTopicState() {
    ever(_userService.isLogined, (_) {
      if (_userService.isLogined.value == false) {
        //清空点赞状态
        for (UnSplashImageInfo imageInfo in imageInfos) {
          imageInfo.likeByUser = false;
        }
      }
    });
  }
}
