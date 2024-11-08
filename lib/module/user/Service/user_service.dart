import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:splash/config/storage/local_storage.dart';
import 'package:splash/module/search_module/Model/users.dart';
import 'package:splash/module/user/Model/user_access.dart';
import 'package:splash/net/api.dart';

const UserAuthInfoAccessKey = "UserAuthInfoAccessKey";
const UserAuthInfoID = "UserAuthInfoID";
const UserAuthInfoUserName = "UserAuthInfoUserName";

class UserService extends GetxService {
  final isLogined = false.obs;
  final Rx<UserAccessModel?> userAuthInfo = Rx<UserAccessModel?>(null);
  final Rx<UnsplashUserInfo?> userInfo = Rx<UnsplashUserInfo?>(null);

  @override
  void onInit() {
    ever(isLogined, (_) {
      //When Login State Change , Fetch User Info Again
      log("User Login State Change,Fetch User Info");
      if (isLogined.value) {
        fetchUserInfo();
      }
    });

    loadUserAuthInfo();

    super.onInit();
  }

  void loadUserAuthInfo() {
    //Load AccessKey
    var accessToken = LocalStorage.get(UserAuthInfoAccessKey);
    var userID = LocalStorage.get(UserAuthInfoID);
    var userName = LocalStorage.get(UserAuthInfoUserName);
    if (accessToken != null && userID != null && userName != null) {
      userAuthInfo.value = UserAccessModel(accessToken, userID, userName);
      isLogined.value = true;
    }
  }

  void onSetUserAuthInfo(UserAccessModel? accessModel) {
    if (accessModel == null) {
      return;
    }
    log("On SetUserAuthInfo");
    LocalStorage.save(UserAuthInfoAccessKey, accessModel.accessToken);
    LocalStorage.save(UserAuthInfoID, accessModel.userID!);
    LocalStorage.save(UserAuthInfoUserName, accessModel.userName);
    userAuthInfo.value = accessModel;
    isLogined.value = true;
  }

  Future logout() async {
    isLogined.value = false;
    userAuthInfo.value = null;
    userInfo.value = null;
  }

  Future fetchUserInfo() async {
    if (isLogined.value == false) {
      return;
    }

    try {
      //Get Private Info
      // var res = await httpManager.netFetch(
      //     'https://api.unsplash.com/me',
      //     null,
      //     {
      //       "Authorization": "Bearer ${userAuthInfo.value!.accessToken}",
      //     },
      //     null);

      //Get Public Info
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/users/${userAuthInfo.value!.userID}',
          null,
          null,
          null);
      if (res != null && res.data != null) {
        userInfo.value =
            UnsplashUserInfo.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      print("Fetch User Info Error:$e");
    }
  }
}
