// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestBase _$RestBaseFromJson(Map<String, dynamic> json) {
  return RestBase(
    status: json['status'] as String?,
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestBaseToJson(RestBase instance) => <String, dynamic>{
      'status': instance.status,
      'errors': instance.errors,
    };

RestStringData _$RestStringDataFromJson(Map<String, dynamic> json) {
  return RestStringData(
    status: json['status'] as String?,
    data: json['data'] as String?,
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestStringDataToJson(RestStringData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'errors': instance.errors,
    };

RestNumberData _$RestNumberDataFromJson(Map<String, dynamic> json) {
  return RestNumberData(
    status: json['status'] as String?,
    data: (json['data'] as num?)?.toDouble(),
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestNumberDataToJson(RestNumberData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'errors': instance.errors,
    };

RestObjData _$RestObjDataFromJson(Map<String, dynamic> json) {
  return RestObjData(
    status: json['status'] as String?,
    data: json['data'],
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestObjDataToJson(RestObjData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'errors': instance.errors,
    };

RestListData _$RestListDataFromJson(Map<String, dynamic> json) {
  return RestListData(
    status: json['status'] as String?,
    data: json['data'] as List<dynamic>?,
    total: json['recordsTotal'] as int?,
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestListDataToJson(RestListData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'errors': instance.errors,
    };

RestMapData _$RestMapDataFromJson(Map<String, dynamic> json) {
  return RestMapData(
    status: json['status'] as String?,
    data: jsonDecode(json['data']) as Map<String, dynamic>?,
    total: json['recordsTotal'] as int?,
    errors: (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestMapDataToJson(RestMapData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'errors': instance.errors,
    };
RestErrorDetail _$RestErrorDetailFromJson(Map<String, dynamic> json) {
  return RestErrorDetail(
    code: json['code'] as int?,
    message: json['message'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$RestErrorDetailToJson(RestErrorDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': instance.type,
      'message': instance.message,
    };
