import 'package:get/state_manager.dart';
import 'package:splash/model/unsplash_image_model.dart';
import 'package:splash/module/main_module/ApiModule/random_photos.dart';
import 'package:splash/module/main_module/ApiModule/topic_request.dart';
import 'package:splash/module/main_module/Model/topic_model.dart';

class MainModuleController extends GetxController {
  var isLoading = true.obs;
  var unsplashImageInfos = RxList<UnSplashImageInfo>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    print("MainModuleController On Init");
    // fetchRandomPhotos();
    super.onInit();
  }

  void fetchRandomPhotos() async {
    print("Fetching Random Photos");
    try {
      isLoading(true);
      var photos = await RandomPhotosRequest.requestRandomPhoto();
      if (photos != null) {
        unsplashImageInfos.assignAll(photos);
      }
    } catch (e) {
    } finally {
      isLoading(false);
      update();
    }
  }
}

class MainModuleTopicController extends GetxController {
  var topicList = RxList<TopicModel>([]);
  var isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

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
        topicList.assignAll(topics);
      }
    } catch (e) {
    } finally {
      isLoading(false);
      update();
    }
  }
}
