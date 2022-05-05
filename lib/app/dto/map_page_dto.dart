import 'package:latlong2/latlong.dart';

class MapPageDto {
  String? title;
  int? layerId;
  int? featureId;
  LatLng? featureLatLng;
  bool routeFromDsLop;

  MapPageDto({
    this.title,
    this.layerId,
    this.featureId,
    this.featureLatLng,
    this.routeFromDsLop = false,
  });
}
