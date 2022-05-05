import 'package:map_module/config/app_localization.dart';
import 'package:nylo_framework/nylo_framework.dart';

Future<void> boot() async {
  /// NyLocalization
  await NyLocalization.instance.init(
      localeType: localeType,
      languageCode: languageCode,
      languagesList: languagesList,
      assetsDirectory: assetsDirectory,
      valuesAsMap: valuesAsMap);

  /// ...
}
