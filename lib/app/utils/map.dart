// ignore_for_file: must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:map_module/app/constants/layer_id.dart';
import 'package:map_module/bootstrap/helpers.dart';
import 'package:map_module/config/app_theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import "package:latlong2/latlong.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'dart:math' as math;
import '../helpers/string_helper.dart';

class MapUtils {
  static showInfor(BuildContext context, int layerId,
      Map<String, dynamic> attributes, LatLng location) async {
    showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      backgroundColor: ThemeColor.get(context).background,
      builder: (context) => StatefulBuilder(builder: (context, innerSetState) {
        switch (layerId) {
          case LayerEnum.thietBiDongCatCaoThe:
            return ThietBiDongCatPopup(attributes: attributes);
          case LayerEnum.mayBienApCaoThe:
            return MayBienApPopup(
              attributes: attributes,
            );
          case LayerEnum.tramBienApCaoThe:
            return TramBienApPopup(
              attributes: attributes,
            );
          case LayerEnum.thietBiDoDemCaoThe:
            return ThietBiDoDemPopup(attributes: attributes);
          case LayerEnum.cotDienCaoThe:
            return CotDienPopup(attributes: attributes);
          case LayerEnum.viTriSuCo:
            return SuCoPopup(
              attributes: attributes,
            );
          case LayerEnum.scadaTrungThe:
            return ScadaPopup(
              attributes: attributes,
            );
          case LayerEnum.tramBienApTrungThe:
            return TramBienApPopup(
              attributes: attributes,
            );
          case LayerEnum.diemDoHaThe:
            return DiemDoPopup(
              attributes: attributes,
            );

          default:
            return Container();
        }
      }),
    );
  }

  static Future<void> animatedMapMove(TickerProvider ticker,
      MapController mapController, LatLng destLocation, double destZoom) async {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: Duration(
            milliseconds: (mapController.zoom - destZoom).abs().toInt() * 200),
        vsync: ticker);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
    if (mapController.zoom < 17 || mapController.center != destLocation) {
      await controller.forward();
    }
  }
}

class TramBienApPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  TramBienApPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  // ignore: prefer_if_null_operators
                  'Trạm ${attributes['TENTRAMBIENAP'] != null ? attributes['TENTRAMBIENAP'] : "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID : ${attributes["ID"] ?? attributes["OBJECTID"]}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      attributes['CONGSUAT'] == null
                          ? getImageAsset('map/tram_bien_ap/other.png')
                          : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) == 110
                              ? getImageAsset('map/tram_bien_ap/110.png')
                              : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) == 220
                                  ? getImageAsset('map/tram_bien_ap/220.png')
                                  : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) == 500
                                      ? getImageAsset(
                                          'map/tram_bien_ap/500.png')
                                      : getImageAsset(
                                          'map/tram_bien_ap/other.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${StringHelper.isNullOrEmpty(attributes["MATRAMBIENAP"]) != true ? attributes["MATRAMBIENAP"] : "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["XUATTUYEN"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.green,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CHEDOVANHANH"] ?? "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bolt,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CONGSUAT"] != null ? '${attributes["CONGSUAT"]}' + "kV" : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          MdiIcons.update,
                          color: Colors.blue,
                        ),
                        Text(
                            '  ${attributes["NGAYCAPNHAT"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["NGAYCAPNHAT"] as int))) : "không có"}'),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 80,
                      child: Text(
                          'Đơn vị quản lý: ${attributes["DONVIQUANLY"] ?? "không có"}'),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ScadaPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  ScadaPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Text(
                // ignore: prefer_if_null_operators
                'Mã hiệu: ${attributes['TENTRAMBIENAP'] != null ? attributes['TENTRAMBIENAP'] : "Không có"}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ID : ${attributes["ID"] ?? attributes["OBJECTID"]}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: attributes['TRANGTHAITHIETBI'] != null
                        ? (attributes['TRANGTHAITHIETBI'] as int) == 1
                            ? Image.asset(
                                getImageAsset('map/scada/1.png'),
                                width: 80,
                                height: 100,
                                scale: 0.4,
                              )
                            : Image.asset(
                                getImageAsset('map/scada/2.png'),
                                width: 80,
                                height: 100,
                                scale: 0.4,
                              )
                        : Image.asset(
                            getImageAsset('map/scada/2.png'),
                            width: 80,
                            height: 100,
                            scale: 0.4,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["LOAITHIETBI"] ?? "không có"} ',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["XUATTUYEN"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: Colors.green,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["VITRILAPDAT"] ?? "không có"} ',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bolt,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["TRANGTHAITHIETBI"] != null ? attributes["TRANGTHAITHIETBI"] == 1 ? "Đang hoạt động" : "Không hoạt động" : "Không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          MdiIcons.update,
                          color: Colors.blue,
                        ),
                        Text(
                            '  ${attributes["NGAYCAPNHAT"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["NGAYCAPNHAT"] as int))) : "không có"}'),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 80,
                      child: Text(
                          'Đơn vị quản lý: ${attributes["DONVIQUANLY"] ?? "không có"}'),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CotDienPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  CotDienPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Cột ${attributes['THIETBI'] ?? "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["ID"] ?? attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      attributes['CONGSUAT'] == null
                          ? getImageAsset('map/cot_dien/other.png')
                          : (attributes['CONGSUAT'] as int) == 110
                              ? getImageAsset('map/cot_dien/110.png')
                              : (attributes['CONGSUAT'] as int) == 220
                                  ? getImageAsset('map/cot_dien/220.png')
                                  : (attributes['CONGSUAT'] as int) == 500
                                      ? getImageAsset('map/cot_dien/500.png')
                                      : getImageAsset('map/cot_dien/other.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["MATRAMBIENAP"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["XUATTUYEN"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CHEDOVANHANH"] ?? "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bolt,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CONGSUAT"] != null ? '${attributes["CONGSUAT"]}' + "kV" : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(MdiIcons.update),
                        Text(
                            '  ${attributes["NGAYCAPNHAT"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["NGAYCAPNHAT"] as int))) : "không có"}'),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: Text(
                        'Đơn vị quản lý: ${attributes["DONVIQUANLY"] ?? "không có"}',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ThietBiDongCatPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  ThietBiDongCatPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Thiết bị ${attributes['THIETBI'] ?? "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      getImageAsset('map/thiet_bi_dong_cat/dao_cach_ly.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["MATRAMBIENAP"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["VI_TRI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CHEDOVANHANH"] ?? "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.bolt,
                            size: 20,
                          ),
                          Text(
                            ' : ${attributes["CONGSUAT"] != null ? '${attributes["CONGSUAT"]}' + "kV" : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(MdiIcons.update),
                        Text(
                            '  ${attributes["X"] != null ? DateFormat('dd/MM/yyyy').format(attributes["X"]) : "không có"}'),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      child: Text(
                        'Đơn vị quản lý: ${attributes["DONVIQUANLY"] ?? "không có"}',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MayBienApPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  MayBienApPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Máy biến áp ${attributes['SOSERIAL'] ?? "không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["IDTRAMBIENAP"] ?? attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      attributes['LOAIMBA'] == null
                          ? getImageAsset('map/may_bien_ap/khac.png')
                          : (attributes['LOAIMBA'] as int) == 1
                              ? getImageAsset('map/may_bien_ap/luc_1.png')
                              : getImageAsset('map/may_bien_ap/tu_dung_1.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["DIA_CHI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["VI_TRI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 20,
                            color: Colors.green,
                          ),
                          Text(
                            ' : ${attributes["HIENTRANG_ID"] != null ? int.parse(attributes["HIENTRANG_ID"] as String) == 1 ? "Đã khắc phục" : int.parse(attributes["HIENTRANG_ID"] as String) == 2 ? "Đang khắc phục" : "Chưa khắc phục" : "Không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.clock,
                            size: 20,
                          ),
                          Text(
                            '  ${attributes["THOI_GIAN"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["THOI_GIAN"] as int))) : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(MdiIcons.noteEditOutline),
                    Text(
                        '  ${attributes["GHI_CHU"] != null ? attributes["GHI_CHU"] : "không có ghi chú"}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ThietBiDoDemPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  ThietBiDoDemPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'thiết bị ${attributes['SOSERIAL'] ?? "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      attributes['SOSERIAL'] == null
                          ? getImageAsset('map/thiet_bi_do_dem/other.png')
                          : (attributes['SOSERIAL'] as int) == 1
                              ? getImageAsset('map/thiet_bi_do_dem/MOF.png')
                              : (attributes['SOSERIAL'] as int) == 2
                                  ? getImageAsset('map/thiet_bi_do_dem/TI.png')
                                  : getImageAsset('map/thiet_bi_do_dem/TU.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["DIA_CHI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["VI_TRI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 20,
                            color: Colors.green,
                          ),
                          Text(
                            ' : ${attributes["HIENTRANG_ID"] != null ? int.parse(attributes["HIENTRANG_ID"] as String) == 1 ? "Đã khắc phục" : int.parse(attributes["HIENTRANG_ID"] as String) == 2 ? "Đang khắc phục" : "Chưa khắc phục" : "Không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.clock,
                            size: 20,
                          ),
                          Text(
                            '  ${attributes["THOI_GIAN"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["THOI_GIAN"] as int))) : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(MdiIcons.noteEditOutline),
                    Text(
                        '  ${attributes["GHI_CHU"] != null ? attributes["GHI_CHU"] : "không có ghi chú"}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DiemDoPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  DiemDoPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Điểm đo ${attributes['TENTRAMBIENAP'] ?? "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      getImageAsset('map/diem_do/other.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["MALO"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["DIACHIDIEMDO"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 20,
                            color: Colors.green,
                          ),
                          Text(
                            ' : ${attributes["HIENTRANG_ID"] != null ? int.parse(attributes["HIENTRANG_ID"] as String) == 1 ? "Đã khắc phục" : int.parse(attributes["HIENTRANG_ID"] as String) == 2 ? "Đang khắc phục" : "Chưa khắc phục" : "Không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.clock,
                            size: 20,
                          ),
                          Text(
                            '  ${attributes["NGAYKHOITAO"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["NGAYKHOITAO"] as int))) : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(MdiIcons.noteEditOutline),
                    Text(
                        '  ${attributes["GHI_CHU"] != null ? attributes["GHI_CHU"] : "không có ghi chú"}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SuCoPopup extends StatelessWidget {
  Map<String, dynamic> attributes;
  SuCoPopup({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Sự cố ${attributes['MA_VITRISUCO'] ?? "Không có tên"}',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ID : ${attributes["OBJECTID"]}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Image.asset(
                      getImageAsset('map/thiet_bi_do_dem/other.png'),
                      width: 80,
                      height: 100,
                      scale: 0.4,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.information,
                            size: 20,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["DIA_CHI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.mapMarker,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              ' : ${attributes["VI_TRI"] ?? "không có"}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 20,
                            color: Colors.green,
                          ),
                          Text(
                            ' : ${attributes["HIENTRANG_ID"] != null ? int.parse(attributes["HIENTRANG_ID"] as String) == 1 ? "Đã khắc phục" : int.parse(attributes["HIENTRANG_ID"] as String) == 2 ? "Đang khắc phục" : "Chưa khắc phục" : "Không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.clock,
                            size: 20,
                          ),
                          Text(
                            '  ${attributes["THOI_GIAN"] != null ? DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch((attributes["THOI_GIAN"] as int))) : "không có"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(MdiIcons.noteEditOutline),
                    Text(
                        '  ${attributes["GHI_CHU"] != null ? attributes["GHI_CHU"] : "không có ghi chú"}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.red.shade600],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.6, 0.6),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hiển thị trên bản đồ",
                        style: TextStyle(
                            color: lightColors.background, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
