import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ThietBiDongCatWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  ThietBiDongCatWidgetMarker({Key? key, required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes.entries.first != null
                ? attributes.entries.first.value as String
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            getImageAsset('map/cot_dien/other.png'),
            width: 40,
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FittedBox(
  //     fit: BoxFit.scaleDown,
  //     child: Column(
  //       children: [
  //         Text(
  //           (attributes['THIETBI'] != null
  //               ? attributes['THIETBI'] as String
  //               : (attributes['OBJECTID'] as int).toString()),
  //           style: const TextStyle(
  //               color: Colors.black, fontWeight: FontWeight.bold),
  //         ),
  //         Image.asset(
  //           attributes['CONGSUAT'] == null
  //               ? getImageAsset('map/thiet_bi_dong_cat/dao_cach_ly.png')
  //               : double.tryParse((attributes['CONGSUAT'] as String)) == 110
  //                   ? getImageAsset('map/tram_bien_ap/110.png')
  //                   : double.tryParse((attributes['CONGSUAT'] as String)) == 220
  //                       ? getImageAsset('map/tram_bien_ap/220.png')
  //                       : double.tryParse((attributes['CONGSUAT'] as String)) ==
  //                               500
  //                           ? getImageAsset('map/tram_bien_ap/500.png')
  //                           : getImageAsset('map/cot_dien/other.png'),
  //           width: 40,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
