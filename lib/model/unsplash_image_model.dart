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

  @JsonKey(name: "created_at")
  String? createdAt;

  UnsplashImageInfoExif? exif;
  UnsplashImageInfoLinks? links;

  UnsplashCollectionCoverPhotoPreviewPhotoUrl? urls;
  UnsplashUserInfo user;
  UnSplashImageInfo(this.id, this.urls, this.user, this.width, this.height,
      this.likes, this.altDescription);

  factory UnSplashImageInfo.fromJson(Map<String, dynamic> json) =>
      _$UnSplashImageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnSplashImageInfoToJson(this);
}

@JsonSerializable()
class UnsplashImageInfoExif {
  String? make;
  String? model;
  String? name;
  @JsonKey(name: "exposure_time")
  String? exposureTime;
  UnsplashImageInfoExif();
  String? aperture;
  @JsonKey(name: "focal_length")
  String? focalLength;
  int? iso;

  factory UnsplashImageInfoExif.fromJson(Map<String, dynamic> json) =>
      _$UnsplashImageInfoExifFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashImageInfoExifToJson(this);
}

@JsonSerializable()
class UnsplashImageInfoLinks {
  String self;
  String html;
  String download;
  @JsonKey(name: "download_location")
  String downloadLocation;

  UnsplashImageInfoLinks(
      this.self, this.html, this.download, this.downloadLocation);

  factory UnsplashImageInfoLinks.fromJson(Map<String, dynamic> json) =>
      _$UnsplashImageInfoLinksFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashImageInfoLinksToJson(this);
}
