// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordModel _$ChangePasswordModelFromJson(Map<String, dynamic> json) {
  return ChangePasswordModel(
    oldPassword: json['OldPasswd'] as String,
    newPassword: json['NewPasswd'] as String,
    confirmNewPassword: json['ConfirmNewPasswd'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordModelToJson(
        ChangePasswordModel instance) =>
    <String, dynamic>{
      'OldPasswd': instance.oldPassword,
      'NewPasswd': instance.newPassword,
      'ConfirmNewPasswd': instance.confirmNewPassword,
    };
