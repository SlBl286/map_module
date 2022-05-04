import 'package:flutter_app/app/models/rest_base.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: "address")
  String address;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "dob")
  int dob;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lng")
  double lng;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "location")
  String location;
  @JsonKey(name: "note")
  String note;
  @JsonKey(name: "phone_number")
  String phoneNumber;
  @JsonKey(name: "position")
  String position;
  @JsonKey(name: "unit")
  String unit;
  @JsonKey(name: "date_str")
  String dateStr;

  UserInfo({
    this.address = "",
    this.fullName = "",
    this.dob = 0,
    this.gender = "",
    this.lat = 0,
    this.lng = 0,
    this.region = "",
    this.location = "",
    this.phoneNumber = "",
    this.position = "",
    this.unit = "",
    this.dateStr = "",
    this.note = "",
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UserInfoResponse extends RestBase {
  UserInfo? data;

  UserInfoResponse({this.data});

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}

@JsonSerializable()
class UserInfoListResponse extends RestBase {
  List<UserInfo>? data;

  UserInfoListResponse({this.data});
  factory UserInfoListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserInfoListResponseToJson(this);
}
