import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
import 'package:splash/module/search_module/Model/users.dart';

part 'colleciton.g.dart';

@JsonSerializable()
class UnsplashCollectionInfo {
  String id;
  String title;
  @JsonKey(name: "total_photos")
  int totalPhotos;
  @JsonKey(name: "cover_photo")
  UnsplashCollectionCoverPhoto? coverPhoto;

  UnsplashUserInfo user;

  @JsonKey(name: "preview_photos")
  List<UnsplashCollectionCoverPhotoPreviewPhoto>? previewPhotos;
  UnsplashCollectionInfo(this.id, this.title, this.coverPhoto, this.totalPhotos,
      this.previewPhotos, this.user);

  factory UnsplashCollectionInfo.fromJson(Map<String, dynamic> json) =>
      _$UnsplashCollectionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashCollectionInfoToJson(this);
}

@JsonSerializable()
class UnsplashCollectionCoverPhoto {
  String id;

  UnsplashCollectionCoverPhoto(this.id);

  factory UnsplashCollectionCoverPhoto.fromJson(Map<String, dynamic> json) =>
      _$UnsplashCollectionCoverPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashCollectionCoverPhotoToJson(this);
}

@JsonSerializable()
class UnsplashCollectionCoverPhotoPreviewPhoto {
  String id;
  UnsplashCollectionCoverPhotoPreviewPhotoUrl? urls;
  UnsplashCollectionCoverPhotoPreviewPhoto(this.id, this.urls);

  factory UnsplashCollectionCoverPhotoPreviewPhoto.fromJson(
          Map<String, dynamic> json) =>
      _$UnsplashCollectionCoverPhotoPreviewPhotoFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UnsplashCollectionCoverPhotoPreviewPhotoToJson(this);
}

@JsonSerializable()
class UnsplashCollectionCoverPhotoPreviewPhotoUrl {
  String thumb;
  String small;
  String regular;
  String full;
  String raw;

  UnsplashCollectionCoverPhotoPreviewPhotoUrl(
      this.thumb, this.small, this.regular, this.full, this.raw);

  factory UnsplashCollectionCoverPhotoPreviewPhotoUrl.fromJson(
          Map<String, dynamic> json) =>
      _$UnsplashCollectionCoverPhotoPreviewPhotoUrlFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UnsplashCollectionCoverPhotoPreviewPhotoUrlToJson(this);
}
