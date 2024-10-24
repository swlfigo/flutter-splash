import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/Model/topic_model.dart';
import 'package:splash/net/api.dart';

class RandomPhotosRequest {
  static Future<List<UnSplashImageInfo>?> requestRandomPhoto() async {
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/photos/random", {"count": 10}, null, null);
    if (res != null && res.data != null) {
      List<UnSplashImageInfo> fetchedImages = (res.data as List<dynamic>)
          .map((item) =>
              UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
          .toList();
      return fetchedImages;
    }
    return null;
  }
}
