import 'package:dozens_advices/screens/home_screen.dart';
import 'package:dozens_advices/screens/splash_screen.dart';
import 'package:dozens_advices/utils/FadeRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DozensAdvicesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Use only portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        theme: ThemeData(backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (setting) {
          switch (setting.name) {
            case SplashScreen.ROUTE:
              return SplashScreen().getRoute(setting);
            case HomeScreen.ROUTE:
              return HomeScreen().getRoute();
            default:
              return SplashScreen().getRoute(setting);
          }
        });
  }
}
