import 'package:dozens_advices/utils/FadeRoute.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomeScreen {
  static const String ROUTE = "/home";

  Route getRoute({RouteSettings settings}) =>
      FadeRoute(builder: (context) => _ScreenLayout());
}

class _ScreenLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScreenLayoutState();
  }
}

class _ScreenLayoutState extends State<_ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(tabs: [
          Tab(icon: Icon(Icons.fiber_new)),
          Tab(text: "t",)
        ]),
        appBar: GradientAppBar(
          backgroundColorStart: Color(0xff7FC6FF),
          backgroundColorEnd: Color(0xff4678FF),
          title: Text("dozens Advices"),
        ),
      ),
    );
  }
}
