import 'package:json_annotation/json_annotation.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordModel({this.oldPassword = "", this.newPassword = "", this.confirmNewPassword = ""});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => _$ChangePasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);
}
