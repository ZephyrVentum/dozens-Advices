import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/bloc/new_advice/new_advice_bloc.dart';
import 'package:dozens_advices/resources/menu.dart';
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
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),
              BlocProvider<NewAdviceBloc>(builder: (context) => NewAdviceBloc()),
              BlocProvider<ConfigureBloc>(builder: (context) => ConfigureBloc()),
              BlocProvider<HistoryBloc>(builder: (context) => HistoryBloc()),
              BlocProvider<FavouritesBloc>(builder: (context) => FavouritesBloc())
            ],
          ));
}

class _ScreenLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<_ScreenLayout> with TickerProviderStateMixin {
  TabController _tabController;
  TabBloc _tabBloc;
  HistoryBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _tabBloc = BlocProvider.of<TabBloc>(context);
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _tabController = TabController(length: Tabs.values.length, vsync: this)
      ..addListener(() {
        _tabBloc.dispatch(SelectPositionEvent(Tabs.values[_tabController.index]));
      });
  }

  @override
  Widget build(BuildContext context) {
    return TabControlInheritedWidget(
      _tabController,
      child: BlocBuilder(
        builder: (_, state) {
          Tabs selectedTab = (state as SelectedTabState).selectedTab;
          return Stack(children: <Widget>[
            Scaffold(
              backgroundColor: Color(0xEEFFFFFF),
              appBar: GradientAppBar(
                actions: _getAppBarActions(selectedTab),
                backgroundColorStart: Styles.startGradientColor,
                backgroundColorEnd: Styles.endGradientColor,
                title: _getAppBarTitle(selectedTab),
              ),
              bottomNavigationBar: _buildBottomNavTabBar(),
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[NewAdviceScreen(), ConfigureScreen(), HistoryScreen(), FavouritesScreen()],
              ),
            ),
            _buildHomeTabBarButton()
          ]);
        },
        bloc: BlocProvider.of<TabBloc>(context),
      ),
    );
  }

  Widget _getAppBarTitle(Tabs tab) {
    Widget title;
    switch (tab) {
      case Tabs.NewAdvice:
        title = RichText(
            text: TextSpan(children: [
          TextSpan(text: Strings.dozensLogo, style: Styles.boldAppBarTextStyle(context)),
          TextSpan(text: "  "),
          TextSpan(text: Strings.advicesLogo, style: Theme.of(context).textTheme.title)
        ]));
        break;
      case Tabs.Configurations:
        title = Text(Strings.configureTab, style: Theme.of(context).textTheme.title);
        break;
      case Tabs.History:
        title = Text(Strings.historyTab, style: Theme.of(context).textTheme.title);
        break;
      case Tabs.Favourites:
        title = Text(Strings.favouritesTab, style: Theme.of(context).textTheme.title);
        break;
    }
    return title;
  }

  List<Widget> _getAppBarActions(Tabs tab) {
    List<Widget> actions = List();
    switch (tab) {
      case Tabs.History:
        actions.add(Material(
          color: Colors.transparent,
          child: PopupMenuButton<SortMenuItem>(
            onSelected: (menuItem) {
              _historyBloc.dispatch(SortAdvicesEvent(menuItem.sortType));
            },
            icon: Icon(Icons.sort),
            itemBuilder: (context) {
              SortType selectedSortType = _historyBloc.sortType;
              return Menus.sortMenu.map((SortMenuItem menuItem) {
                return PopupMenuItem<SortMenuItem>(
                    value: menuItem,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(menuItem.title, style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18))),
                        Icon(Icons.done,
                            color: menuItem.sortType == selectedSortType
                                ? Styles.averageGradientColor
                                : Colors.transparent)
                      ],
                    ));
              }).toList();
            },
          ),
        ));

        actions.add(Material(
          color: Colors.transparent,
          child: PopupMenuButton<FilterMenuItem>(
            onSelected: (menuItem) {
              _historyBloc.dispatch(FilterByTypeEvent(menuItem.adviceType));
            },
            icon: Icon(Icons.filter_list),
            itemBuilder: (_) {
              String selectedFilterType = _historyBloc.filterAdviceType;
              return Menus.filterMenu.map((FilterMenuItem menuItem) {
                return PopupMenuItem<FilterMenuItem>(
                    value: menuItem,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(menuItem.title, style: Theme.of(context).textTheme.display2.copyWith(fontSize: 18))),
                        Icon(Icons.done,
                            color: menuItem.adviceType == selectedFilterType
                                ? Styles.averageGradientColor
                                : Colors.transparent)
                      ],
                    ));
              }).toList();
            },
          ),
        ));
        break;
      default:
        break;
    }
    return actions;
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
                _tabController.index = 0;
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
                          color: _tabController.index == 0 ? Colors.black : Styles.inactiveHomeTabColor,
                          width: 20,
                          image: AssetImage("assets/images/d_logo.png")),
                    ),
                    Hero(
                      tag: dHero,
                      child: Image(
                          color: _tabController.index == 0 ? Colors.black : Styles.inactiveHomeTabColor,
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
                color: _tabController.index == 0 ? Colors.black : Styles.inactiveHomeTabColor,
                width: _tabController.index == 0 ? 6 : 5),
            shape: BoxShape.circle,
          ),
        ),
      ],
    ));
  }

  Widget _buildBottomNavTabBar() {
    return GradientBottomNavigationBar(
      onTap: (pos) {
        _tabController.index = pos;
      },
      backgroundColorStart: Styles.startGradientColor,
      backgroundColorEnd: Styles.endGradientColor,
      fixedColor: Colors.black,
      currentIndex: _tabController.index,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Container(), title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.tune),
            title: Text(
              Strings.configureTab,
              style: Styles.tabTextStyle(context),
            )),
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

class TabControlInheritedWidget extends InheritedWidget {
  TabControlInheritedWidget(this.tabController, {Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  final TabController tabController;

  static TabControlInheritedWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(TabControlInheritedWidget);
}
