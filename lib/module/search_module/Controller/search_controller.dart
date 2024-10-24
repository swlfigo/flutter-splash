import 'package:splash/model/unsplash_image_model.dart';
import 'package:get/state_manager.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';
import 'package:splash/module/search_module/Model/users.dart';
import 'package:splash/net/api.dart';

class SearchPhotoController extends GetxController {
  var selectedSegementIndex = (-1).obs;
  final searchText = ''.obs;

  var searchResults = RxList<UnSplashImageInfo>([]);

  final searchPhotosResults = [].obs;
  final searchUsersResults = [].obs;
  final searchCollectionResults = [].obs;

  final isLoading = false.obs;
  void search(String keyword) async {
    isLoading.value = true;
    try {
      switch (selectedSegementIndex.value) {
        case 0:
          await searchPhoto(keyword);
          break;
        case 1:
          await searchCollection(keyword);
          break;
        case 2:
          await searchUser(keyword);
          break;
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<UnSplashImageInfo>?> searchPhoto(String keyword) async {
    if (keyword == "") {
      return null;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/search/photos",
        {"query": keyword},
        null,
        null);
    if (res != null && res.data != null) {
      searchPhotosResults.value =
          ((res.data as Map<String, dynamic>)["results"] as List<dynamic>)
              .map((item) =>
                  UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
              .toList();
    }
    return null;
  }

  Future<List<UnsplashUserInfo>?> searchUser(String userName) async {
    if (userName == "") {
      return null;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/search/users",
        {"query": userName},
        null,
        null);
    if (res != null && res.data != null) {
      searchUsersResults.value =
          ((res.data as Map<String, dynamic>)["results"] as List<dynamic>)
              .map((item) =>
                  UnsplashUserInfo.fromJson((item as Map<String, dynamic>)))
              .toList();
    }
    return null;
  }

  Future<List<UnsplashCollectionInfo>?> searchCollection(
      String collection) async {
    if (collection == "") {
      return null;
    }
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/search/collections",
        {"query": collection},
        null,
        null);
    if (res != null && res.data != null) {
      searchCollectionResults.value =
          ((res.data as Map<String, dynamic>)["results"] as List<dynamic>)
              .map((item) {
        try {
          var j =
              UnsplashCollectionInfo.fromJson((item as Map<String, dynamic>));
          return j;
        } catch (e) {}
      }).toList();
    }
    return null;
  }

  void onSegmentChanged(int index) {
    selectedSegementIndex.value = index;
    if (searchText.value.isNotEmpty) {
      search(searchText.value);
    }
  }

  void onSearchTextChanged(String keyword) {
    //Same Keyword Not Search
    if (keyword.compareTo(searchText.value) == 0) {
      return;
    }
    searchText.value = keyword;
    if (selectedSegementIndex.value == -1) {
      selectedSegementIndex.value = 0;
    }
    search(searchText.value);
  }
}
