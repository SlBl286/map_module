import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SuCoWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  SuCoWidgetMarker({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes['VI_TRI'] != null
                ? attributes['VI_TRI'] as String
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            getImageAsset('map/thiet_bi_do_dem/other.png'),
            width: 50,
          ),
        ],
      ),
    );
  }
}
