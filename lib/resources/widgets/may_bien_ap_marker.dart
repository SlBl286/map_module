import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MayBienApWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  MayBienApWidgetMarker({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes['SOSERIAL'] != null
                ? attributes['SOSERIAL'] as String
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            attributes['LOAIMBA'] == null
                ? getImageAsset('map/may_bien_ap/khac.png')
                : (attributes['LOAIMBA'] as int) == 1
                    ? getImageAsset('map/may_bien_ap/luc_1.png')
                    : getImageAsset('map/may_bien_ap/tu_dung_1.png'),
            width: 40,
          ),
        ],
      ),
    );
  }
}
