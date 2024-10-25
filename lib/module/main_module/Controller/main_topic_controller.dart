import 'package:get/get.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/net/api.dart';

class MainTopicListController extends GetxController {
  //separate controller with different topic title
  final String topic;
  MainTopicListController(this.topic);
  var imageInfos = RxList<UnSplashImageInfo>([]);
  var isLoading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    fetchTopicData();
    super.onReady();
  }

  void fetchTopicData() async {
    isLoading.value = true;
    try {
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/topics/${topic}/photos', null, null, null);
      if (res != null && res.data != null) {
        imageInfos.value = (res.data as List<dynamic>)
            .map((item) =>
                UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
            .toList();
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
