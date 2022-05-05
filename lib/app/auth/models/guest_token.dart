import 'package:json_annotation/json_annotation.dart';

part 'guest_token.g.dart';

@JsonSerializable()
class GuestToken {
  String accessToken;
  String guestToken;

  GuestToken({
    required this.accessToken,
    required this.guestToken,
  });

  factory GuestToken.fromJson(Map<String, dynamic> json) =>
      _$GuestTokenFromJson(json);

  Map<String, dynamic> toJson() => _$GuestTokenToJson(this);
}

@JsonSerializable()
class GuestTokenRequest {
  String grantType;

  GuestTokenRequest(this.grantType);

  factory GuestTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$GuestTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GuestTokenRequestToJson(this);
}

@JsonSerializable()
class GuestTokenResponse {
  GuestToken data;

  GuestTokenResponse({
    required this.data
  });

  factory GuestTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$GuestTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuestTokenResponseToJson(this);
}
