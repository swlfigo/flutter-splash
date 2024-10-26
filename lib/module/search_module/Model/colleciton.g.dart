// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colleciton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashCollectionInfo _$UnsplashCollectionInfoFromJson(
        Map<String, dynamic> json) =>
    UnsplashCollectionInfo(
      json['id'] as String,
      json['title'] as String,
      json['cover_photo'] == null
          ? null
          : UnsplashCollectionCoverPhoto.fromJson(
              json['cover_photo'] as Map<String, dynamic>),
      (json['total_photos'] as num).toInt(),
      (json['preview_photos'] as List<dynamic>?)
          ?.map((e) => UnsplashCollectionCoverPhotoPreviewPhoto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      UnsplashUserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnsplashCollectionInfoToJson(
        UnsplashCollectionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'total_photos': instance.totalPhotos,
      'cover_photo': instance.coverPhoto,
      'user': instance.user,
      'preview_photos': instance.previewPhotos,
    };

UnsplashCollectionCoverPhoto _$UnsplashCollectionCoverPhotoFromJson(
        Map<String, dynamic> json) =>
    UnsplashCollectionCoverPhoto(
      json['id'] as String,
    );

Map<String, dynamic> _$UnsplashCollectionCoverPhotoToJson(
        UnsplashCollectionCoverPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UnsplashCollectionCoverPhotoPreviewPhoto
    _$UnsplashCollectionCoverPhotoPreviewPhotoFromJson(
            Map<String, dynamic> json) =>
        UnsplashCollectionCoverPhotoPreviewPhoto(
          json['id'] as String,
          json['urls'] == null
              ? null
              : UnsplashCollectionCoverPhotoPreviewPhotoUrl.fromJson(
                  json['urls'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$UnsplashCollectionCoverPhotoPreviewPhotoToJson(
        UnsplashCollectionCoverPhotoPreviewPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
    };

UnsplashCollectionCoverPhotoPreviewPhotoUrl
    _$UnsplashCollectionCoverPhotoPreviewPhotoUrlFromJson(
            Map<String, dynamic> json) =>
        UnsplashCollectionCoverPhotoPreviewPhotoUrl(
          json['thumb'] as String,
          json['small'] as String,
          json['regular'] as String,
        );

Map<String, dynamic> _$UnsplashCollectionCoverPhotoPreviewPhotoUrlToJson(
        UnsplashCollectionCoverPhotoPreviewPhotoUrl instance) =>
    <String, dynamic>{
      'thumb': instance.thumb,
      'small': instance.small,
      'regular': instance.regular,
    };
