import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigureScreen extends StatefulWidget {
  @override
  _ConfigureScreenState createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  ConfigureBloc _configureBloc;

  @override
  void initState() {
    _configureBloc = BlocProvider.of<ConfigureBloc>(context);
    _configureBloc.dispatch(LoadStoredConfigureEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _configureBloc,
        builder: (_, state) {
          switch (state.runtimeType) {
            case InitialConfigureState:
              return buildConfigureState((state as InitialConfigureState).configs);
            default:
              return buildConfigureState(Configs());
          }
        });
  }

  Widget buildConfigureState(Configs configs) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(Strings.frequencyContentTypeConfigure,
                textAlign: TextAlign.center, style: Styles.infoTextStyle(context)),
          ),
          SizedBox(
            height: 8,
          ),
          buildSliderSection(
              Strings.moralityConfigure, Strings.amoralConfigure, Strings.cherubicConfigure, configs.molarity, (value) {
            _configureBloc.dispatch(MolarityConfigureEvent(value));
          }),
          SizedBox(
            height: 20,
          ),
          buildSliderSection(
              Strings.politicsConfigure, Strings.unpoliticalConfigure, Strings.politicalConfigure, configs.politics,
              (value) {
            _configureBloc.dispatch(PoliticsConfigureEvent(value));
          }),
          SizedBox(
            height: 20,
          ),
          buildSliderSection(Strings.geekConfigure, Strings.monkeyConfigure, Strings.nerdConfigure, configs.geek,
              (value) {
            _configureBloc.dispatch(GeekConfigureEvent(value));
          }),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  RaisedGradientButton(
                      onPressed: () {
                        _configureBloc.dispatch(RefreshConfigureEvent());
                      },
                      child: Icon(Icons.refresh),
                      gradient: LinearGradient(colors: [Styles.startGradientColor, Styles.endGradientColor])),
                  const SizedBox(
                    width: 8,
                  ),
                  RaisedGradientButton(
                      onPressed: () {
                        _configureBloc.dispatch(ShuffleConfigureEvent());
                      },
                      child: Icon(Icons.shuffle),
                      gradient: LinearGradient(colors: [Styles.startGradientColor, Styles.endGradientColor]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliderSection(
          String mainTitle, String lowTitle, String highTitle, sliderValue, Function(double) onSliderValueChange) =>
      Column(
        children: <Widget>[
          Text(mainTitle, style: Styles.infoTextStyleHighlighted(context).copyWith(letterSpacing: 1.3, fontSize: 34)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(children: <Widget>[
              Expanded(
                child: Text(lowTitle, style: Styles.tabTextStyle(context).copyWith(color: Styles.averageGradientColor)),
              ),
              Expanded(
                child: Text(highTitle,
                    textAlign: TextAlign.end,
                    style: Styles.tabTextStyle(context).copyWith(color: Styles.endGradientColor)),
              ),
            ]),
          ),
          Slider(value: sliderValue, onChanged: onSliderValueChange),
        ],
      );
}
