import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class TramBienApWidgetMarker extends StatelessWidget {
  Map<String, dynamic> attributes;
  TramBienApWidgetMarker({Key? key, required this.attributes})
      : super(key: key);

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
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Image.asset(
            attributes['CONGSUAT'] == null
                ? getImageAsset('map/tram_bien_ap/other.png')
                : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) ==
                        110
                    ? getImageAsset('map/tram_bien_ap/110.png')
                    : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) == 220
                        ? getImageAsset('map/tram_bien_ap/220.png')
                        : (attributes['CONGSUAT'] is int
                            ? attributes['CONGSUAT'] as int
                            : int.tryParse(attributes['CONGSUAT'] as String)) == 500
                            ? getImageAsset('map/tram_bien_ap/500.png')
                            : getImageAsset('map/tram_bien_ap/other.png'),
            width: 50,
          ),
        ],
      ),
    );
  }
}
