// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnSplashImageInfo _$UnSplashImageInfoFromJson(Map<String, dynamic> json) =>
    UnSplashImageInfo(
      json['id'] as String,
      json['urls'] == null
          ? null
          : UnsplashCollectionCoverPhotoPreviewPhotoUrl.fromJson(
              json['urls'] as Map<String, dynamic>),
      UnsplashUserInfo.fromJson(json['user'] as Map<String, dynamic>),
      (json['width'] as num).toInt(),
      (json['height'] as num).toInt(),
      (json['likes'] as num).toInt(),
      json['alt_description'] as String,
    )..color = json['color'] as String?;

Map<String, dynamic> _$UnSplashImageInfoToJson(UnSplashImageInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'likes': instance.likes,
      'color': instance.color,
      'alt_description': instance.altDescription,
      'urls': instance.urls,
      'user': instance.user,
    };
