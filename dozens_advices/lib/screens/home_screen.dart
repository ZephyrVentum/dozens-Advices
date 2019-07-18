import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/utils/FadeRoute.dart';
import 'package:dozens_advices/widgets/BottomNavBar.dart';
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

class _ScreenLayoutState extends State<_ScreenLayout>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: Colors.grey,
        appBar: GradientAppBar(
          backgroundColorStart: Styles.startGradientColor,
          backgroundColorEnd: Styles.endGradientColor,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: Strings.dozensLogo,
                style: Styles.boldAppBarTextStyle(context)),
            TextSpan(text: "  "),
            TextSpan(
                text: Strings.advicesLogo,
                style: Theme.of(context).textTheme.title)
          ])),
        ),
        bottomNavigationBar:
            BottomNavigationBar(backgroundColor: Colors.transparent, items: [
          BottomNavigationBarItem(icon: Container(), title: Container()),
          BottomNavigationBarItem(icon: Container(), title: Container())
        ]),
        body: Container(),
      ),
      _buildBottomNavTabBar(context)
    ]);
  }

  Widget _buildBottomNavTabBar(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 24),
              child: GradientBottomNavigationBar(
                backgroundColorStart: Styles.startGradientColor,
                backgroundColorEnd: Styles.endGradientColor,
                fixedColor: Colors.black,
                currentIndex: 3,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Container(), title: Container()),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.tune),
                      title: Text(Strings.configureTab)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      title: Text(Strings.historyTab),
                      activeIcon: Icon(Icons.format_list_bulleted)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      title: Text(Strings.favouritesTab),
                      activeIcon: Icon(Icons.favorite)),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(-15, 15, 0),
              width: 80,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 9, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Hero(
                      tag: "key1",
                      child: Image(
                          width: 20,
                          image: AssetImage("assets/images/d_logo.png")),
                    ),
                    Hero(
                      tag: "key2",
                      child: Image(
                          width: 21,
                          image: AssetImage("assets/images/a_logo.png")),
                    )
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                color: Styles.startGradientColor,
                border: Border.all(color: Colors.black, width: 6),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ));
  }
}
