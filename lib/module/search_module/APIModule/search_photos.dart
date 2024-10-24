import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/net/api.dart';

class SearchPhotoAPIRequest {
  static Future<List<UnSplashImageInfo>?> requestRandomPhoto(
      String keyword) async {
    if (keyword == "") {
      return null;
    }
    try {
      var res = await httpManager.netFetch(
          "https://api.unsplash.com/search/photos",
          {"query": keyword},
          null,
          null);
      if (res != null && res.data != null) {
        var returnSearchList =
            (res.data as Map<String, dynamic>)["results"] as List<dynamic>;
        List<UnSplashImageInfo> imageList = [];

        for (var i = 0; i < returnSearchList.length; i++) {
          var imageI = UnSplashImageInfo.fromJson((returnSearchList[i]));
          imageList.add(imageI);
        }
        return imageList;
      }
      return null;
    } catch (e) {
      return null;
    } finally {}
  }
}
