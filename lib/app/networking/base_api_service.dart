import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:map_module/app/auth/auth_state_manager.dart';
import 'package:map_module/app/utils/dialogs.dart';

abstract class HasApiOperations {
  String get baseUrl;
  BaseOptions? get baseOptions;
  bool? get useInterceptor;
}

class BaseDioApiService {
  late Dio api;
  BuildContext? _context;
  BaseOptions? baseOptions;
  final String baseUrl = "";
  bool useInterceptor = false;

  BaseDioApiService(BuildContext? context) {
    _context = context;
    init();
  }

  void init() {
    baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    api = Dio(baseOptions);

    if (useInterceptor == true) {
      _addInterceptor();
    }
  }

  _addInterceptor() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // Do something before request is sent
      String token = "";
      try {
        token = await AuthStateManager.instance.getTokenWithType() ?? "";
      } catch (e) {
        token = "";
      }

      options.headers = {"Authorization": token};

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      // Do something with response error
      if (e is TimeoutException) {
        DialogUtils.notiDialog(_context!, text: "Lỗi kết nối máy chủ");
      }
      if (e is DioError) {
        if (e.response != null) {
          if (e.response!.statusCode == 500) {
            DialogUtils.notiDialog(_context!, text: "Lỗi kết nối máy chủ");
          }
        }
      }
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }
}
