import 'package:get/state_manager.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/ApiModule/random_photos.dart';
import 'package:splash/module/main_module/ApiModule/topic_request.dart';
import 'package:splash/module/main_module/Model/topic_model.dart';

class MainModuleTopicController extends GetxController {
  final topicList = RxList<TopicModel>([]).obs;
  final selectedTopicIndex = (-1).obs;

  var isLoading = true.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    fetchTopicsList();
    super.onReady();
  }

  void fetchTopicsList() async {
    try {
      isLoading(true);
      var topics = await TopicsRequest.requestTopic();
      if (topics != null) {
        topicList.value.assignAll(topics);
        selectedTopicIndex.value = 0;
      } else {
        selectedTopicIndex.value = -1;
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  void onTabbarSelected(int index) {
    selectedTopicIndex.value = index;
  }
}
