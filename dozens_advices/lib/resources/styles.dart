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

// START OF TEXT STYLES REGION //

  static TextStyle boldLogoTextStyle(BuildContext context) =>
      regularLogoTextStyle(context).copyWith(fontFamily: 'GilroyExtraBold');

  static TextStyle regularLogoTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display1;

  static TextStyle tabTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display2.copyWith(fontSize: 14);

  static TextStyle buttonTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.button;

  static TextStyle boldAppBarTextStyle(BuildContext context) =>
      Theme.of(context)
          .textTheme
          .title
          .copyWith(color: Colors.black, fontFamily: 'GilroyExtraBold');

  static TextStyle infoTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display2.copyWith(fontSize: 21);

  static advicesListDateTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display2.copyWith(fontSize: 14);

  static advicesListContentTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.display2.copyWith(fontSize: 16);

  static TextStyle infoTextStyleHighlighted(BuildContext context) =>
      infoTextStyle(context).copyWith(fontFamily: 'GilroyMedium', fontSize: 23);

// END OF TEXT STYLES REGION //

  ThemeData get appThemeData => ThemeData(
        textTheme: TextTheme(
            display1: const TextStyle(
                color: Colors.black, fontSize: 42, fontFamily: 'GilroyRegular'),
            display2: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'GilroyRegular',
            ),
            button: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'GilroyMedium',
            ),
            title: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'GilroyRegular',
            )),
      );

  static const startGradientColor = Color(0xff7FC6FF);
  static const endGradientColor = Color(0xff4678FF);
  static const averageGradientColor = Color(0xff629FFF);
  static const highlightInkWellColor = Color(0x7f4678FF);
  static const inactiveHomeTabColor = Color(0xff19325E);
}
