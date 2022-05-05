// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestToken _$GuestTokenFromJson(Map<String, dynamic> json) {
  return GuestToken(
    accessToken: json['access_token'] as String,
    guestToken: json['guest_token'] as String,
  );
}

Map<String, dynamic> _$GuestTokenToJson(GuestToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'guest_token': instance.guestToken,
    };

GuestTokenRequest _$GuestTokenRequestFromJson(Map<String, dynamic> json) {
  return GuestTokenRequest(
    json['grant_type'] as String,
  );
}

Map<String, dynamic> _$GuestTokenRequestToJson(GuestTokenRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
    };

GuestTokenResponse _$GuestTokenResponseFromJson(Map<String, dynamic> json) {
  return GuestTokenResponse(
    data: GuestToken.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GuestTokenResponseToJson(GuestTokenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
