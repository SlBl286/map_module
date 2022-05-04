// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    address: json['address'] as String,
    fullName: json['full_name'] as String,
    dob: json['dob'] as int,
    gender: json['gender'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    region: json['region'] as String,
    location: json['location'] as String,
    phoneNumber: json['phone_number'] as String,
    position: json['position'] as String,
    unit: json['unit'] as String,
    dateStr: json['date_str'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'address': instance.address,
      'full_name': instance.fullName,
      'dob': instance.dob,
      'gender': instance.gender,
      'lat': instance.lat,
      'lng': instance.lng,
      'region': instance.region,
      'location': instance.location,
      'note': instance.note,
      'phone_number': instance.phoneNumber,
      'position': instance.position,
      'unit': instance.unit,
      'date_str': instance.dateStr,
    };

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) {
  return UserInfoResponse(
    data: json['data'] == null
        ? null
        : UserInfo.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..status = json['status'] as String?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errors': instance.errors,
      'data': instance.data,
    };

UserInfoListResponse _$UserInfoListResponseFromJson(Map<String, dynamic> json) {
  return UserInfoListResponse(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..status = json['status'] as String?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserInfoListResponseToJson(
        UserInfoListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errors': instance.errors,
      'data': instance.data,
    };
