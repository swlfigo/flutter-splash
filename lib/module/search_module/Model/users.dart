import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class UnsplashUserInfo {
  String id;
  String username;
  String name;

  @JsonKey(name: "profile_image")
  UnsplashUserAvatarInfo profileImage;
  UnsplashUserInfo(this.id, this.username, this.name, this.profileImage);

  factory UnsplashUserInfo.fromJson(Map<String, dynamic> json) =>
      _$UnsplashUserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashUserInfoToJson(this);
}

@JsonSerializable()
class UnsplashUserAvatarInfo {
  String small;
  String medium;
  UnsplashUserAvatarInfo(this.small, this.medium);

  factory UnsplashUserAvatarInfo.fromJson(Map<String, dynamic> json) =>
      _$UnsplashUserAvatarInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashUserAvatarInfoToJson(this);
}
