import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/constants/layer_id.dart';
import 'package:flutter_app/app/constants/map_const.dart';
import 'package:flutter_app/app/controllers/map_controller.dart';
import 'package:flutter_app/app/utils/map.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/widgets/cot_dien_marker.dart';
import 'package:flutter_app/resources/widgets/diem_do_marker.dart';
import 'package:flutter_app/resources/widgets/may_bien_ap_marker.dart';
import 'package:flutter_app/resources/widgets/scada_marker.dart';
import 'package:flutter_app/resources/widgets/su_co.dart';
import 'package:flutter_app/resources/widgets/thiet_bi_do_dem_widget.dart';
import 'package:flutter_app/resources/widgets/thiet_bi_dong_cat_marker.dart';
import 'package:flutter_app/resources/widgets/tram_bien_ap_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:math' as math;
import "package:latlong2/latlong.dart";
class MapPage extends NyStatefulWidget {
  static const route = "/map";
  final MapPageController controller = MapPageController();

  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends NyState<MapPage> with TickerProviderStateMixin {
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  List<Polygon> _polygons = [];
  String? _featureType;
  String? _title;
  int? _layerId;
  int? featureId;
  LatLng? featureLatLng;
  late MapController mapController;
  bool _routeFromDslop = false;
  @override
  widgetDidLoad() async {
    if (widget.data() != null) {
      setState(() {
        _title = widget.data()[0];
        _layerId = widget.data()[1];
        if (widget.data().length > 2) {
          featureId = (widget.data()[2] as double).toInt();
          featureLatLng = widget.data()[3];
          _routeFromDslop = true;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showInfor(BuildContext context, Map<String, dynamic> atributes) async {
    showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        // ignore: unnecessary_const
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      backgroundColor: ThemeColor.get(context).background,
      builder: (context) => StatefulBuilder(builder: (context, innerSetState) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  const Center(
                    child: Icon(
                      Icons.horizontal_rule,
                      size: 30,
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    height: 375,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      child: Column(
                          children: atributes.entries.map((atribute) {
                        if (atribute.value != null) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withAlpha(100),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Text(atribute.key + " : ",
                                      style: const TextStyle(fontSize: 14)),
                                  FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        atribute.value
                                            .toString()
                                            .replaceAll("_", " "),
                                        maxLines: 2,
                                        style: const TextStyle(fontSize: 13),
                                        softWrap: true,
                                      ))
                                ]),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }).toList()),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void _onMapCreated(MapController controller) async {
    mapController = controller;

    await widget.controller.loadGeoJson(_layerId!);
    setState(() {
      for (var item in widget.controller.features) {
        switch (_layerId) {
          case LayerEnum.thietBiDongCatCaoThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: ThietBiDongCatWidgetMarker(
                        attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.thietBiDoDemCaoThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child:
                        ThietBiDoDemWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.mayBienApCaoThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: MayBienApWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.tramBienApCaoThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: TramBienApWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.tramBienApTrungThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: TramBienApWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.cotDienCaoThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: CotDienWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.duongDayCaoThe:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.nenTramCaoThe:
            if (item.geometryPylygon != null) {
              _polygons.add(
                Polygon(
                    points: item.geometryPylygon!.coordinates.first,
                    borderStrokeWidth: 2,
                    color: Colors.blue.withAlpha(150),
                    borderColor: Colors.grey),
              );
            }
            break;
          case LayerEnum.scadaTrungThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: ScadaWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.tuPhanPhoiHaThe:
            if (item.geometryPylygon != null) {
              _polygons.add(
                Polygon(
                    points: item.geometryPylygon!.coordinates.first,
                    borderStrokeWidth: 2,
                    color: Colors.blue.withAlpha(150),
                    borderColor: Colors.grey),
              );
            }
            break;
          case LayerEnum.diemChuyenMachBTS:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: SuCoWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.dayDanCaoThe:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.duongDayHaThe:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.duongDayTrungThe:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.tuyenCapNgamBTS:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.tuyenCapTreoBTS:
            if (item.geometryLineString != null) {
              _polylines.add(
                Polyline(
                  points: item.geometryLineString!.coordinates,
                  strokeWidth: 3,
                  color: Colors.blueAccent,
                ),
              );
            }
            break;
          case LayerEnum.viTriSuCo:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: SuCoWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.diemDoHaThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: DiemDoMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.thietBiDongCatHaThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: SuCoWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.thietBiDoDemHaThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: ThietBiDoDemWidgetMarker(
                          attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.congToKhachHangHaThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: SuCoWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          case LayerEnum.cotDienHaThe:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () async {
                      await MapUtils.animatedMapMove(this, mapController,
                          item.geometryPoint!.coordinates, 17);
                      if (item.properties != null) {
                        if (kDebugMode) {
                          print(item.properties);
                        }
                        MapUtils.showInfor(context, _layerId!, item.properties!,
                            item.geometryPoint!.coordinates);
                      }
                    },
                    child: SuCoWidgetMarker(attributes: item.properties!),
                  ),
                ),
              );
            }
            break;
          case LayerEnum.nenTramTrungThe:
            if (item.geometryPylygon != null) {
              _polygons.add(
                Polygon(
                    points: item.geometryPylygon!.coordinates.first,
                    borderStrokeWidth: 2,
                    color: Colors.blue.withAlpha(150),
                    borderColor: Colors.grey),
              );
            }
            break;
          case LayerEnum.diemKhachHang:
            if (item.geometryPoint != null) {
              _markers.add(
                Marker(
                  rotate: true,
                  width: 150.0,
                  height: 40.0,
                  point: item.geometryPoint!.coordinates,
                  builder: (ctx) => GestureDetector(
                      onTap: () async {
                        await MapUtils.animatedMapMove(this, mapController,
                            item.geometryPoint!.coordinates, 17);
                        if (item.properties != null) {
                          if (kDebugMode) {
                            print(item.properties);
                          }
                          MapUtils.showInfor(
                              context,
                              _layerId!,
                              item.properties!,
                              item.geometryPoint!.coordinates);
                        }
                      },
                      child: SuCoWidgetMarker(attributes: item.properties!)),
                ),
              );
            }
            break;
          default:
            if (item.geometryLineString != null) {
              debugPrint(_layerId.toString());
              debugPrint("LineString");
            }
            if (item.geometryPoint != null) {
              debugPrint(_layerId.toString());
              debugPrint("Point");
            }
            if (item.geometryPylygon != null) {
              debugPrint(_layerId.toString());
              debugPrint("Polygon");
            }
            break;
        }
      }
    });
    if (widget.data().length > 2) {
      Future.delayed(Duration(milliseconds: 500), () {
        MapUtils.animatedMapMove(
            this,
            mapController,
            widget.controller.features
                .where((element) => element.id == featureId)
                .first
                .geometryPoint!
                .coordinates,
            17);
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        MapUtils.showInfor(
          context,
          _layerId!,
          widget.controller.features
              .where((element) => element.id == featureId)
              .first
              .properties!,
          widget.controller.features
              .where((element) => element.id == featureId)
              .first
              .geometryPoint!
              .coordinates,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            pop();
            if (_routeFromDslop) pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                  size: const Size.fromRadius(17),
                  child: SvgPicture.asset(getImageAsset('logo-small.svg'))),
            ),
            const SizedBox(
              width: 7,
            ),
            FittedBox(
              child: Text(
                "Bản đồ " + (_title ?? "").toLowerCase(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            getImageAsset('bg_home_2.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                onTap: ((tapPosition, point) => debugPrint(point.toString())),
                onMapCreated: _onMapCreated,
                // onPositionChanged: (a, b) => log(a.zoom.toString() ),
                center: LatLng(20.997802, 105.792635),
                zoom: 10.0,
                maxZoom: 18.5,
                minZoom: 1,
                plugins: [
          
                ],
              ),
              layers: [
                TileLayerOptions(
                  maxZoom: 18.5,
                  minZoom: 1,
                  urlTemplate: MapConst.host + MapConst.coordinates,
                ),
                PolylineLayerOptions(
                  polylines: _polylines,
                  polylineCulling: true,
                ),
                PolygonLayerOptions(
                  polygons: _polygons,
                  polygonCulling: true,
                ),
                MarkerLayerOptions(
                  rotate: true,
                  markers: _markers,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
