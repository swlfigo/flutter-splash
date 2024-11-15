import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';

import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';
import 'package:splash/module/search_module/Model/users.dart';
import 'package:splash/net/api.dart';

class UserController extends GetxController {
  String? _userName;
  String? _userID;
  Rx<UnsplashUserInfo?> userInfo = Rx<UnsplashUserInfo?>(null);

  @override
  void onInit() {
    if (_userID != null) {
      fetchUserData();
    }
    super.onInit();
  }

  void setUpUserID(String? userID) {
    if (userID != null) {
      _userID = userID;
      fetchUserInfo();
    }
  }

  void setUpUserName(String? userName) {
    if (userName != null) {
      _userName = userName;
    }
  }

  var selectedSegementIndex = (0).obs;

  RxList<UnSplashImageInfo> userPhotos = RxList<UnSplashImageInfo>([]);
  RxList<UnSplashImageInfo> userLikes = RxList<UnSplashImageInfo>([]);
  RxList<UnsplashCollectionInfo> userCollections =
      RxList<UnsplashCollectionInfo>([]);

  @override
  void onClose() {
    // TODO: implement onClose
    log("User Controller Closed,UserID:$_userID,UserName:$_userName");
    super.onClose();
  }

  void onSegmentChanged(int index) {
    selectedSegementIndex.value = index;
    fetchUserData();
  }

  void fetchUserPhotos() async {
    await _fetchUserPhotos();
  }

  Future _fetchUserPhotos() async {
    if (_userName == null) {
      return;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/users/${_userName}/photos", null, null, null);
    if (res != null && res.data != null) {
      userPhotos.value = (res.data as List<dynamic>)
          .map((item) =>
              UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
          .toList();
    }
  }

  Future _fetchUserCollection() async {
    if (_userName == null) {
      return;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/users/${_userName}/collections",
        null,
        null,
        null);
    if (res != null && res.data != null) {
      userCollections.value = (res.data as List<dynamic>)
          .map((item) =>
              UnsplashCollectionInfo.fromJson((item as Map<String, dynamic>)))
          .toList();
    }
  }

  void fetchUserCollection() async {
    await _fetchUserCollection();
  }

  Future _fetchUserLiked() async {
    if (_userName == null) {
      return;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/users/${_userName}/likes",
        null,
        {"need_auth": true},
        null);
    if (res != null && res.data != null) {
      userLikes.value = (res.data as List<dynamic>)
          .map((item) =>
              UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
          .toList();
    }
  }

  void fetchUserLiked() async {
    await _fetchUserLiked();
  }

  Future fetchUserInfo() async {
    if (_userID == null) {
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
          'https://api.unsplash.com/users/${_userID!}', null, null, null);
      if (res != null && res.data != null) {
        userInfo.value =
            UnsplashUserInfo.fromJson(res.data as Map<String, dynamic>);
      }
    } catch (e) {
      print("Fetch User Info Error:$e");
    }
  }

  void fetchUserData() {
    switch (selectedSegementIndex.value) {
      case 0:
        //Fetch User's Photos
        fetchUserPhotos();
        break;
      case 1:
        fetchUserLiked();
        break;
      case 2:
        fetchUserCollection();
        break;
      default:
    }
  }

  void logout() {
    userInfo.value = null;
  }
}
