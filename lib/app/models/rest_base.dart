import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part "rest_base.g.dart";

@JsonSerializable()
class RestBase {
  String? status;
  List<RestErrorDetail>? errors;

  RestBase({
    this.status,
    this.errors,
  });

  factory RestBase.fromJson(Map<String, dynamic> json) =>
      _$RestBaseFromJson(json);

  Map<String, dynamic> toJson() => _$RestBaseToJson(this);
}

@JsonSerializable()
class RestStringData {
  String? status;
  String? data;
  List<RestErrorDetail>? errors;

  RestStringData({this.status, this.data, this.errors});

  factory RestStringData.fromJson(Map<String, dynamic> json) =>
      _$RestStringDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestStringDataToJson(this);
}

@JsonSerializable()
class RestNumberData {
  String? status;
  double? data;
  List<RestErrorDetail>? errors;

  RestNumberData({this.status, this.data, this.errors});

  factory RestNumberData.fromJson(Map<String, dynamic> json) =>
      _$RestNumberDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestNumberDataToJson(this);
}

@JsonSerializable()
class RestObjData {
  String? status;
  Object? data;
  List<RestErrorDetail>? errors;

  RestObjData({this.status, this.data, this.errors});

  factory RestObjData.fromJson(Map<String, dynamic> json) =>
      _$RestObjDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestObjDataToJson(this);
}

@JsonSerializable()
class RestListData {
  String? status;
  List<dynamic>? data;
  List<RestErrorDetail>? errors;
  int? total;

  RestListData({this.status, this.data, this.errors, this.total});

  factory RestListData.fromJson(Map<String, dynamic> json) =>
      _$RestListDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestListDataToJson(this);
}

@JsonSerializable()
class RestMapData {
  String? status;
  Map<String,dynamic>? data;
  List<RestErrorDetail>? errors;
  int? total;

  RestMapData({this.status, this.data, this.errors, this.total});

  factory RestMapData.fromJson(Map<String, dynamic> json) =>
      _$RestMapDataFromJson(json);

  Map<String, dynamic> toJson() => _$RestMapDataToJson(this);
}

@JsonSerializable()
class RestErrorDetail {
  int? code;
  String? type;
  String? message;

  RestErrorDetail({this.code, this.message, this.type});

  factory RestErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$RestErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$RestErrorDetailToJson(this);
}
