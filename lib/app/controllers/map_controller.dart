import 'dart:developer';

import 'package:map_module/app/models/feature.dart';
import 'package:map_module/app/networking/api_service.dart';
import 'package:flutter_map/flutter_map.dart';

import 'controller.dart';

class MapPageController extends Controller {
  late ApiService _apiService;
  List<Feature> features = [];
  MapPageController() : super() {
    _apiService = ApiService(buildContext: context);
  }

  Future<List<Feature>> loadGeoJson(int layerId, {String? keySearch}) async {
    var response = await _apiService.layerGetgeoJsonForLayer(layerId,
        keySearch: keySearch);
    if (response.data != null && response.status != "ERROR") {
      // log(response.data.toString());
      for (var item in (response.data!['features'] as List)) {
        features.add(Feature.fromJson(item));
      }
    }
    // print(features);
    return features;
  }
}
