// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashUserInfo _$UnsplashUserInfoFromJson(Map<String, dynamic> json) =>
    UnsplashUserInfo(
      json['id'] as String,
      json['username'] as String,
      json['name'] as String,
      UnsplashUserAvatarInfo.fromJson(
          json['profile_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnsplashUserInfoToJson(UnsplashUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'profile_image': instance.profileImage,
    };

UnsplashUserAvatarInfo _$UnsplashUserAvatarInfoFromJson(
        Map<String, dynamic> json) =>
    UnsplashUserAvatarInfo(
      json['small'] as String,
      json['medium'] as String,
    );

Map<String, dynamic> _$UnsplashUserAvatarInfoToJson(
        UnsplashUserAvatarInfo instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
    };
