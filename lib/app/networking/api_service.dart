import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:map_module/app/models/rest_base.dart';
import 'package:map_module/app/networking/base_api_service.dart';

/*
|--------------------------------------------------------------------------
| ApiService
| -------------------------------------------------------------------------
| Uses Dio https://pub.dev/packages/dio
|--------------------------------------------------------------------------
*/

class ApiService extends BaseDioApiService implements HasApiOperations {
  ApiService({BuildContext? buildContext}) : super(buildContext);

  @override
  String get baseUrl => "http://gisgo.vn:8011";

  // @override
  // BaseOptions get baseOptions => BaseOptions();

  @override
  bool get useInterceptor => true;

  // LAYER API
  Future<Map<String, dynamic>> layerGetLayersAndGroupLayersOfUser(
      {bool isAssets = true,
      bool isProblem = false,
      bool isBTS = false}) async {
    var response = await api.get<Map<String, dynamic>>(
        '/api/layer/getLayersAndGroupLayersOfUser',
        queryParameters: {
          'showOnAssets': isAssets,
          'showOnProblem': isProblem,
          'showOnBTS': isBTS,
        });
    if (response.data != null) {
      // debugPrint(response.data!['data']);
    }

    return response.data!;
  }

  Future<RestMapData> layerGetgeoJsonForLayer(int layerId,
      {String? keySearch}) async {
    var response = await api.get<Map<String, dynamic>>(
        '/api/layer/getGeoJSONForLayer',
        queryParameters: {
          'value': keySearch,
          'layerId': layerId,
        });

    return RestMapData.fromJson(response.data!);
  }
}
