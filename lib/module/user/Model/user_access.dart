import 'package:json_annotation/json_annotation.dart';

part 'user_access.g.dart';

@JsonSerializable()
class UserAccessModel {
  @JsonKey(name: "access_token")
  String accessToken;

  @JsonKey(name: "user_id", fromJson: _stringFromInt, toJson: _stringToInt)
  String? userID;

  @JsonKey(name: "username")
  String userName;
  UserAccessModel(this.accessToken, this.userID, this.userName);

  factory UserAccessModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccessModelToJson(this);

  static int? _stringToInt(String? number) {
    number == null ? null : int.parse(number);
  }

  static String? _stringFromInt(int? number) => number?.toString();
}
