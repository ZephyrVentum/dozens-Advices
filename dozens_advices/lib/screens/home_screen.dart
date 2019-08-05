import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/bloc/new_advice/new_advice_bloc.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/screens/configure_screen.dart';
import 'package:dozens_advices/screens/favourites_screen.dart';
import 'package:dozens_advices/screens/history_screen.dart';
import 'package:dozens_advices/screens/new_advice_screen.dart';
import 'package:dozens_advices/utils/routes.dart';
import 'package:dozens_advices/widgets/bottom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomeScreen {
  static const String ROUTE = "/home";

  Route getRoute({RouteSettings settings}) => FadeRoute(
      builder: (context) => MultiBlocProvider(
            child: _ScreenLayout(),
            providers: [
              BlocProvider<NewAdviceBloc>(builder: (context) => NewAdviceBloc()),
              BlocProvider<HistoryBloc>(builder: (context) => HistoryBloc())
            ],
          ));
}

class _ScreenLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<_ScreenLayout>
    with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 0;

  set currentTabIndex(int value) {
    setState(() {
      _currentTabIndex = value;
      _tabController.index = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        currentTabIndex = _tabController.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
        backgroundColor: Color(0xEEFFFFFF),
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
        bottomNavigationBar: _buildBottomNavTabBar(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            NewAdviceScreen(),
            ConfigureScreen(),
            HistoryScreen(),
            FavouritesScreen()
          ],
        ),
      ),
      _buildHomeTabBarButton()
    ]);
  }

  Widget _buildHomeTabBarButton() {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(-15, 15, 0),
          width: 80,
          height: 80,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Styles.highlightInkWellColor,
              splashColor: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              onTap: () {
                currentTabIndex = 0;
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 9, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Hero(
                      tag: aHero,
                      child: Image(
                          color: _currentTabIndex == 0
                              ? Colors.black
                              : Styles.inactiveHomeTabColor,
                          width: 20,
                          image: AssetImage("assets/images/d_logo.png")),
                    ),
                    Hero(
                      tag: dHero,
                      child: Image(
                          color: _currentTabIndex == 0
                              ? Colors.black
                              : Styles.inactiveHomeTabColor,
                          width: 21,
                          image: AssetImage("assets/images/a_logo.png")),
                    )
                  ],
                ),
              ),
            ),
          ),
          decoration: new BoxDecoration(
            color: Styles.startGradientColor,
            border: Border.all(
                color: _currentTabIndex == 0
                    ? Colors.black
                    : Styles.inactiveHomeTabColor,
                width: _currentTabIndex == 0 ? 6 : 5),
            shape: BoxShape.circle,
          ),
        ),
      ],
    ));
  }

  Widget _buildBottomNavTabBar() {
    return GradientBottomNavigationBar(
      onTap: (pos) {
        currentTabIndex = pos;
      },
      backgroundColorStart: Styles.startGradientColor,
      backgroundColorEnd: Styles.endGradientColor,
      fixedColor: Colors.black,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Container(), title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.tune), title: Text(Strings.configureTab, style: Styles.tabTextStyle(context),)),
        BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text(Strings.historyTab, style: Styles.tabTextStyle(context)),
            activeIcon: Icon(Icons.format_list_bulleted)),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(Strings.favouritesTab, style: Styles.tabTextStyle(context)),
            activeIcon: Icon(Icons.favorite)),
      ],
    );
  }
}
