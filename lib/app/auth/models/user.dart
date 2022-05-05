import 'package:map_module/app/models/rest_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String sub;
  String name;
  String phoneNumber;
  String? address;
  String? gender;
  String email;
  String? birthdate;

  User({
    required this.sub,
    required this.name,
    required this.phoneNumber,
    this.address,
    this.gender,
    required this.email,
    this.birthdate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserResponse extends RestBase {
  User? data;

  UserResponse({this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
