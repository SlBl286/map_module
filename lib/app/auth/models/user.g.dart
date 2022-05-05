// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    sub: json['sub'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    address: json['address'] as String?,
    gender: json['gender'] as String?,
    email: json['email'] as String,
    birthdate: json['birthdate'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'sub': instance.sub,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'gender': instance.gender,
      'email': instance.email,
      'birthdate': instance.birthdate,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    data: json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..status = json['status'] as String?
    ..errors = (json['errors'] as List<dynamic>?)
        ?.map((e) => RestErrorDetail.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errors': instance.errors,
      'data': instance.data,
    };
