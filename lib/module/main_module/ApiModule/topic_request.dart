import 'package:splash/module/main_module/Model/topic_model.dart';
import 'package:splash/net/api.dart';

class TopicsRequest {
  static Future<List<TopicModel>?> requestTopic() async {
    var res = await httpManager.netFetch(
        "https://api.unsplash.com/topics", null, null, null);
    if (res != null && res.data != null) {
      List<TopicModel> topicInfos = (res.data as List<dynamic>)
          .map((item) => TopicModel.fromJson((item as Map<String, dynamic>)))
          .toList();
      return topicInfos;
    }
    return null;
  }
}
