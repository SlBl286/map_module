import 'package:map_module/app/models/geo_json.dart';

class Feature {
  final String type;
  final int id;
  final GeoJsonPoint? geometryPoint;
  final GeoJsonPylygon? geometryPylygon;
  final GeoJsonLineString? geometryLineString;
  final Map<String, dynamic>? properties;
  Feature(
      {required this.type,
      required this.id,
      this.geometryPylygon,
      this.geometryPoint,
      this.geometryLineString,
      this.properties});
  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json['type'],
      id: json['id'] as int,
      geometryPoint: json['geometry'] != null
          ? (json['geometry'] as Map)['type'] == 'Point' && (json['geometry'] as Map)['coordinates'].length >0
              ? GeoJsonPoint.fromJson(json['geometry'])
              : null
          : null,
      geometryPylygon: json['geometry'] != null
          ? json['geometry']['type'] == 'Polygon'&& (json['geometry'] as Map)['coordinates'].length >0
              ? GeoJsonPylygon.fromJson(json['geometry'])
              : null
          : null,
      geometryLineString: json['geometry'] != null
          ? json['geometry']['type'] == 'LineString'&& (json['geometry'] as Map)['coordinates'].length >0
              ? GeoJsonLineString.fromJson(json['geometry'])
              : null
          : null,
      properties: json['properties'],
    );
  }
}
