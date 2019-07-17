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
        bottomNavigationBar: Container(
          color: Styles.endGradientColor,

          child: GradientBottomNavigationBar(
            backgroundColorStart: Styles.startGradientColor,
            backgroundColorEnd: Styles.endGradientColor,
            fixedColor: Colors.black,
            currentIndex: 1,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Container(), title: Container()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text("fy lox")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), title: Text('School')),
            ],
          ),
        ),
        appBar: GradientAppBar(
          backgroundColorStart: Styles.startGradientColor,
          backgroundColorEnd: Styles.endGradientColor,
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: Strings.dozensLogo,
                style: Styles.boldAppBarTextStyle(context)),
            TextSpan(text: " "),
            TextSpan(
                text: Strings.advicesLogo,
                style: Theme.of(context).textTheme.title)
          ])),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.deepOrange,
              child: SizedBox(
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
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
                  Image(width: 20, image: AssetImage("assets/images/d_logo.png")),
                  Image(width: 21, image: AssetImage("assets/images/a_logo.png"))
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
      )
    ]);
  }
}
