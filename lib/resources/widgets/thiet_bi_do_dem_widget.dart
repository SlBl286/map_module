import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ThietBiDoDemWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  ThietBiDoDemWidgetMarker({Key? key, required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes['MAHIEU'] != null
                ? attributes['MAHIEU'] as String
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            attributes['SOSERIAL'] == null
                ? getImageAsset('map/thiet_bi_do_dem/other.png')
                : (attributes['SOSERIAL'] as int) == 1
                    ? getImageAsset('map/thiet_bi_do_dem/MOF.png')
                    : (attributes['SOSERIAL'] as int) == 2
                        ? getImageAsset('map/thiet_bi_do_dem/TI.png')
                        : getImageAsset('map/thiet_bi_do_dem/TU.png'),
            width: 40,
          ),
        ],
      ),
    );
  }
}
