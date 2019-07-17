import 'package:flutter/material.dart';

class Styles {
  static Styles _instance;

  Styles._internal();

  factory Styles.getInstance() {
    if (_instance == null) {
      _instance = Styles._internal();
    }
    return _instance;
  }

  static TextStyle boldLogoTextStyle(BuildContext context) =>
      regularLogoTextStyle(context).copyWith(fontFamily: 'GilroyExtraBold');

  static TextStyle regularLogoTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display1;

  static TextStyle boldAppBarTextStyle(BuildContext context) =>
      Theme.of(context)
          .textTheme
          .title
          .copyWith(color: Colors.black, fontFamily: 'GilroyExtraBold');

  ThemeData get appThemeData => ThemeData(
        fontFamily: 'GilroyRegular',
        textTheme: TextTheme(
            display1: TextStyle(color: Colors.black, fontSize: 42),
            title: TextStyle(color: Colors.white, fontSize: 20)),
      );

  static const startGradientColor = Color(0xff7FC6FF);
  static const endGradientColor = Color(0xff4678FF);
}
