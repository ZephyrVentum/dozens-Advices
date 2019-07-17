import 'package:dozens_advices/screens/home_screen.dart';
import 'package:dozens_advices/utils/FadeRoute.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String ROUTE = "/splash";

  Route getRoute(RouteSettings setting) =>
      FadeRoute(builder: build, settings: setting);

  @override
  Widget build(BuildContext context) => _ScreenLayout();
}

class _ScreenLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<_ScreenLayout> {
  double _aLetterOffset = 0;
  double _dLetterOffset = 0;
  var _radius = Radius.circular(0);
  var _isAnimationStarted = false;
  final _splashDuration = const Duration(seconds: 1, milliseconds: 500);
  final _navDuration = const Duration(seconds: 2);
  double _logoOpacity = 0;

  @override
  void initState() {
    super.initState();

  }

  _startAnimationAndNextScreen() {
    if (!_isAnimationStarted) {
      _dLetterOffset = -MediaQuery.of(context).size.width * 0.3 - 200;
      _aLetterOffset = MediaQuery.of(context).size.width * 0.35 + 500;
      _isAnimationStarted = true;
      Future<void>.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _radius = Radius.elliptical(300, 125);
          _aLetterOffset = 0;
          _dLetterOffset = 0;
          _logoOpacity = 1;
        });
        Future<void>.delayed(_navDuration, () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.ROUTE);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _startAnimationAndNextScreen();
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.25,
                    widthFactor: 1,
                    child: AnimatedOpacity(
                      curve: Curves.fastOutSlowIn,
                      duration: _splashDuration,
                      opacity: _logoOpacity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("dozens",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      color: Colors.black,
                                      fontFamily: 'GilroyExtraBold',
                                      fontSize: 42,
                                      fontStyle: FontStyle.normal)),
                          SizedBox(width: 16),
                          Text("Advices",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      color: Colors.black,
                                      fontFamily: 'GilroyRegular',
                                      fontSize: 42))
                        ],
                      ),
                    ),
                  )),
              AnimatedContainer(
                  duration: _splashDuration,
                  curve: Curves.fastOutSlowIn,
                  child: FractionallySizedBox(
                    heightFactor: 0.75,
                    widthFactor: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AnimatedContainer(
                            curve: Curves.decelerate,
                            transform: Matrix4.translationValues(
                                _dLetterOffset, 0.0, 0.0),
                            child: Image(
                                width: MediaQuery.of(context).size.width * 0.3,
                                image: AssetImage("assets/images/d_logo.png")),
                            duration: _splashDuration,
                          ),
                          AnimatedContainer(
                            curve: Curves.decelerate,
                            transform: Matrix4.translationValues(
                                _aLetterOffset, 0.0, 0.0),
                            child: Image(
                                width: MediaQuery.of(context).size.width * 0.35,
                                image: AssetImage("assets/images/a_logo.png")),
                            duration: _splashDuration,
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadiusDirectional.vertical(bottom: _radius),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 1],
                          colors: [Color(0xff7FC6FF), Color(0xff4678FF)])))
            ],
          ),
        )
      ],
    );
  }
}
