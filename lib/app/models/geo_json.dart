import "package:latlong2/latlong.dart";

class GeoJsonPoint {
  final String type;
  final LatLng coordinates;

  GeoJsonPoint({
    required this.type,
    required this.coordinates,
  });
  factory GeoJsonPoint.fromJson(Map<String, dynamic> json) {
    return GeoJsonPoint(
      type: json['type'],
      coordinates: LatLng(
        json['coordinates'][1],
        json['coordinates'][0],
      ),
    );
  }
}

class GeoJsonPylygon {
  final String type;
  final List<List<LatLng>> coordinates;

  GeoJsonPylygon({
    required this.type,
    required this.coordinates,
  });
  factory GeoJsonPylygon.fromJson(Map<String, dynamic> json) {
    List<List<LatLng>> coordinatesList = [];
    List<LatLng> coordinates = [];
    for (var coordinate in json['coordinates']) {
      for (var coordinateItem in coordinate) {
        coordinates.add(LatLng(coordinateItem[1], coordinateItem[0]));
      }
      coordinatesList.add(coordinates);
      coordinates = [];
    }

    return GeoJsonPylygon(
      type: json['type'],
      coordinates: coordinatesList,
    );
  }
}

class GeoJsonLineString {
  final String type;
  final List<LatLng> coordinates;

  GeoJsonLineString({
    required this.type,
    required this.coordinates,
  });
  factory GeoJsonLineString.fromJson(Map<String, dynamic> json) {
    List<LatLng> coordinatesList = [];

    for (var item in json['coordinates']) {
      coordinatesList.add(LatLng(item[1], item[0]));
    }

    return GeoJsonLineString(
      type: json['type'],
      coordinates: coordinatesList,
    );
  }
}
