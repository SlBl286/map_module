import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/home_controller.dart';

import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';

class HomePage extends NyStatefulWidget {
  static const route = "/home";
  final HomeController controller = HomeController();

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  bool _darkMode = false;

  @override
  widgetDidLoad() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    ));
  }
}
