import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:splash/module/user/Service/user_service.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    options.headers.addAll({
      "Content-Type": "application/json",
      'Accept': 'application/json',
    });
    if (!options.headers.containsKey("Authorization")

        // &&
        //         !options.path.contains('topic')

        // &&
        //     options.path.contains('users/swlfigo')
        ) {
      //Common Request
      options.headers
          .addAll({"Authorization": "Client-ID ${dotenv.env["ClientID"]}"});
    } else {
      //Ignore
    }

    if (options.headers.containsKey("need_auth")) {
      var userService = Get.find<UserService>();
      if (userService.isLogined.value) {
        options.headers.addAll({
          "Authorization":
              "Bearer ${userService.userAuthInfo.value!.accessToken}"
        });
      }
    }
    return super.onRequest(options, handler);
  }
}
