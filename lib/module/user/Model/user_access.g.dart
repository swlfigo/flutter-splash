// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccessModel _$UserAccessModelFromJson(Map<String, dynamic> json) =>
    UserAccessModel(
      json['access_token'] as String,
      UserAccessModel._stringFromInt((json['user_id'] as num?)?.toInt()),
      json['username'] as String,
    );

Map<String, dynamic> _$UserAccessModelToJson(UserAccessModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'user_id': UserAccessModel._stringToInt(instance.userID),
      'username': instance.userName,
    };
