import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ScadaWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  ScadaWidgetMarker({Key? key, required this.attributes}) : super(key: key);

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
          attributes['TRANGTHAITHIETBI'] != null
              ? (attributes['TRANGTHAITHIETBI'] as int) == 1
                  ? Image.asset(
                      getImageAsset('map/scada/1.png'),
                      width: 50,
                    )
                  : Image.asset(
                      getImageAsset('map/scada/2.png'),
                      width: 50,
                    )
              : Image.asset(
                  getImageAsset('map/scada/2.png'),
                  width: 50,
                ),
        ],
      ),
    );
  }
}
