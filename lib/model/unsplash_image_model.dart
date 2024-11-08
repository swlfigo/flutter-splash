import 'package:json_annotation/json_annotation.dart';
import 'package:splash/module/search_module/Model/colleciton.dart';
import 'package:splash/module/search_module/Model/users.dart';

part 'unsplash_image_model.g.dart';

@JsonSerializable()
class UnSplashImageInfo {
  String id;
  int width;
  int height;
  int likes;
  String? color;

  @JsonKey(name: "alt_description")
  String? altDescription;

  UnsplashCollectionCoverPhotoPreviewPhotoUrl? urls;
  UnsplashUserInfo user;
  UnSplashImageInfo(this.id, this.urls, this.user, this.width, this.height,
      this.likes, this.altDescription);

  factory UnSplashImageInfo.fromJson(Map<String, dynamic> json) =>
      _$UnSplashImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnSplashImageInfoToJson(this);
}
