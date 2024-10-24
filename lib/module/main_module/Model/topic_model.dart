import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel {
  String id;
  String title;
  String description;
  TopicModel(this.id, this.title, this.description);

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}
