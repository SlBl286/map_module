import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class MarkerWidget extends StatelessWidget {
  Map<String, dynamic> attributes;
  MarkerWidget({Key? key, required this.attributes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        children: [
          Text(
            (attributes['TENTRAMBIENAP'] != null
                ? attributes.entries.first.value.toString()
                : (attributes['OBJECTID'] as int).toString()),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
           
                            getImageAsset('map/tram_bien_ap/other.png'),
            width: 50,
          ),
        ],
      ),
    );
  }
}
