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
      json['alt_description'] as String?,
    )
      ..color = json['color'] as String?
      ..createdAt = json['created_at'] as String?
      ..exif = json['exif'] == null
          ? null
          : UnsplashImageInfoExif.fromJson(json['exif'] as Map<String, dynamic>)
      ..links = json['links'] == null
          ? null
          : UnsplashImageInfoLinks.fromJson(
              json['links'] as Map<String, dynamic>);

Map<String, dynamic> _$UnSplashImageInfoToJson(UnSplashImageInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'likes': instance.likes,
      'color': instance.color,
      'alt_description': instance.altDescription,
      'created_at': instance.createdAt,
      'exif': instance.exif,
      'links': instance.links,
      'urls': instance.urls,
      'user': instance.user,
    };

UnsplashImageInfoExif _$UnsplashImageInfoExifFromJson(
        Map<String, dynamic> json) =>
    UnsplashImageInfoExif()
      ..make = json['make'] as String?
      ..model = json['model'] as String?
      ..name = json['name'] as String?
      ..exposureTime = json['exposure_time'] as String?
      ..aperture = json['aperture'] as String?
      ..focalLength = json['focal_length'] as String?
      ..iso = (json['iso'] as num?)?.toInt();

Map<String, dynamic> _$UnsplashImageInfoExifToJson(
        UnsplashImageInfoExif instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'name': instance.name,
      'exposure_time': instance.exposureTime,
      'aperture': instance.aperture,
      'focal_length': instance.focalLength,
      'iso': instance.iso,
    };

UnsplashImageInfoLinks _$UnsplashImageInfoLinksFromJson(
        Map<String, dynamic> json) =>
    UnsplashImageInfoLinks(
      json['self'] as String,
      json['html'] as String,
      json['download'] as String,
      json['download_location'] as String,
    );

Map<String, dynamic> _$UnsplashImageInfoLinksToJson(
        UnsplashImageInfoLinks instance) =>
    <String, dynamic>{
      'self': instance.self,
      'html': instance.html,
      'download': instance.download,
      'download_location': instance.downloadLocation,
    };
