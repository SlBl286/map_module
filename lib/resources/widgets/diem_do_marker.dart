import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class DiemDoMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  DiemDoMarker({Key? key, required this.attributes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes['TENTRAMBIENAP'] != null
                ? attributes['TENTRAMBIENAP'] as String
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            getImageAsset('map/diem_do/other.png'),
            width: 50,
          ),
        ],
      ),
    );
  }
}
