import 'package:get/get.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/Controller/main_topic_state.dart';
import 'package:splash/net/api.dart';

class MainTopicListController extends GetxController {
  //separate controller with different topic title
  final String topic;
  MainTopicListController(this.topic);
  final MainTopicState state = MainTopicState();

  @override
  void onReady() {
    fetchTopicData();
    super.onReady();
  }

  void fetchTopicData() async {
    state.isLoading.value = true;
    try {
      var res = await httpManager.netFetch(
          'https://api.unsplash.com/topics/${topic}/photos',
          null,
          {"need_auth": true},
          null);
      if (res != null && res.data != null) {
        state.imageInfos.value = (res.data as List<dynamic>)
            .map((item) =>
                UnSplashImageInfo.fromJson((item as Map<String, dynamic>)))
            .toList();
      }
    } catch (e) {
    } finally {
      state.isLoading.value = false;
    }
  }
}
