import 'dart:convert';

import 'package:map_module/app/auth/models/user.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';

import 'implements/invalid_user_exception.dart';
import 'implements/password_not_match_exception.dart';
import 'implements/permission_denided_exception.dart';
import 'implements/verify_phone_exception.dart';

class AuthStateManager {
  final String tokenKey = "___accessToken___";
  final String guest = "___guestToken___";
  final String userInforkey = "__userInfo__";

  final storage = const FlutterSecureStorage();

  static late String _issuer;
  static late String _clientId;
  static late String _clientSecret;

//  final List<String> _scopes = ['openid', 'profile', 'offline_access'];

  static late final AuthStateManager _instance = AuthStateManager();

  static init({@required issuer, @required clientId, @required clientSecret}) {
    debugPrint(" >> AuthStateManager initial.");
    _issuer = issuer;
    _clientId = clientId;
    _clientSecret = clientSecret;
  }

  static AuthStateManager get instance {
    return _instance;
  }

  Future<oauth2.Credentials> login(String username, String password) async {
    debugPrint("tk: $username, mk: $password");
    try {
      final authorizationEndpoint = Uri.parse(_issuer + "/connect/token");
      //
      var client = await oauth2.resourceOwnerPasswordGrant(
        authorizationEndpoint,
        username,
        password,
        identifier: _clientId,
        secret: _clientSecret,
        // scopes: _scopes,
      );
      //
      await storage.delete(key: tokenKey);
      await storage.write(key: tokenKey, value: client.credentials.toJson());

      //
      return client.credentials;
    } catch (e) {
      if (e is AuthorizationException) {
        if (e.description == "phone_number_not_verified") {
          throw PhoneNumberNotVerifedException();
        } else if (e.description == "password_not_match") {
          throw PasswordNotMatchException();
        } else if (e.description == "permission_denided") {
          throw PermissionDenidedException();
        } else if (e.description == "invalid_user") {
          throw InvalidUserException();
        } else {
          throw Exception(e.description);
        }
      } else {
        rethrow;
      }
    }
  }

  Future<bool> refreshToken() async {
    String? tokenJson =
        await storage.read(key: tokenKey).catchError((error) {});
    if (tokenJson != null && tokenJson.isEmpty == false) {
      await storage.delete(key: tokenKey);
      oauth2.Credentials credentials = oauth2.Credentials.fromJson(tokenJson);
      credentials = await credentials
          .refresh(
              identifier: _clientId, secret: _clientSecret, basicAuth: true)
          .catchError((error) async {
        return false;
      });
      await storage.write(key: tokenKey, value: credentials.toJson());
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    await clearSession();
    return true;
  }

  String getIssuer() {
    return _issuer;
  }

  String getBearerToken() {
    return "";
  }

  Future<User?> getUserInfo() async {
    String? userInfoJson =
        await storage.read(key: userInforkey).catchError((error) {});
    if (userInfoJson != null && userInfoJson.isEmpty == false) {
      return User.fromJson(json.decode(userInfoJson));
    }
    //
    return null;
  }

  Future<bool> setUserInfo(User? user) async {
    if (user == null) {
      await storage.delete(key: userInforkey);
    } else {
      await storage.delete(key: userInforkey);
      await storage.write(key: userInforkey, value: json.encode(user.toJson()));
    }
    return true;
  }

  Future<oauth2.Credentials?> getCredentials() async {
    String? tokenJson =
        await storage.read(key: tokenKey).catchError((error) {});
    if (tokenJson != null && tokenJson.isEmpty == false) {
      return oauth2.Credentials.fromJson(tokenJson);
    }
    //
    return null;
  }

  Future<String?> getToken() async {
    String? tokenJson =
        await storage.read(key: tokenKey).catchError((error) {});
    if (tokenJson != null && tokenJson.isEmpty == false) {
      oauth2.Credentials tokenResponse = oauth2.Credentials.fromJson(tokenJson);
      if (tokenResponse.isExpired) {
        await clearSession();
        return null;
      }

      return tokenResponse.accessToken;
    }
    //
    return null;
  }

  Future<String> getTokenType() async {
    return "Bearer";
  }

  Future<String?> getTokenWithType() async {
    String? tokenJson =
        await storage.read(key: tokenKey).catchError((error) {});
    if (tokenJson != null && tokenJson.isEmpty == false) {
      oauth2.Credentials tokenResponse = oauth2.Credentials.fromJson(tokenJson);

      return "Bearer " + tokenResponse.accessToken;
    }
    //
    return null;
  }

  clearSession() async {
    await storage.deleteAll();
  }
}
