import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/widgets/gradient_button.dart';
import 'package:dozens_advices/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAdviceScreen extends StatefulWidget {
  @override
  _NewAdviceScreenState createState() => _NewAdviceScreenState();
}

class _NewAdviceScreenState extends State<NewAdviceScreen> {
  NewAdviceBloc _newAdviceBloc;

  @override
  void initState() {
    _newAdviceBloc = BlocProvider.of<NewAdviceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _newAdviceBloc,
        builder: (BuildContext context, NewAdviceState state) {
          switch (state.runtimeType) {
            case InitialNewAdviceState:
              return buildInitialState();
            case LoadingNewAdviceState:
              return buildLoadingState();
            case NotLoadedAdviceState:
              return buildNotLoadedState((state as NotLoadedAdviceState).error);
            case LoadedAdviceState:
              return buildLoadedState((state as LoadedAdviceState).advice);
            default:
              return Container();
          }
        });
  }

  String getImagePath(Advice advice) {
    switch (advice.type) {
      case AdviceType.ADVICE:
        return "assets/images/ic_advice.png";
      case AdviceType.QUOTE:
        return "assets/images/ic_quote.png";
      case AdviceType.FACT:
        return "assets/images/ic_fact.png";
      case AdviceType.JOKE:
        return "assets/images/ic_joke.png";
      default:
        return "assets/images/ic_advice.png";
    }
  }

  Widget buildLoadedState(Advice advice) => Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Image(image: AssetImage(getImagePath(advice))),
            Text(advice.type.substring(1, advice.type.length),
                style: Styles.infoTextStyleHighlighted(context)
                    .copyWith(letterSpacing: 1.15, fontSize: 27)),
          ]),
          Text(advice.mainContent),
          Row(
            children: <Widget>[
              RaisedGradientButton(
                onPressed: () {
                  _newAdviceBloc.dispatch(LoadNewEvent());
                },
                child: Text(Strings.somethingElseButtonHome,
                    style: Styles.buttonTextStyle(context)),
                gradient: LinearGradient(colors: [
                  Styles.startGradientColor,
                  Styles.endGradientColor
                ]),
              ),
              RaisedGradientButton(
                onPressed: () {
                  _newAdviceBloc.dispatch(LoadNewEvent());
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.deepOrange,
                ),
                gradient: LinearGradient(colors: [
                  Styles.startGradientColor,
                  Styles.endGradientColor
                ]),
              )
            ],
          )
        ],
      ));

  Widget buildNotLoadedState(dynamic error) =>
      Center(child: Text("Ups.\n Something went wrong."));

  Widget buildLoadingState() => Center(child: ProgressBar());

  Widget buildInitialState() => Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(Strings.welcomeHome,
                    style: Styles.regularLogoTextStyle(context)),
                const SizedBox(width: 1, height: 36),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: Strings.descriptionHome,
                        style: Styles.infoTextStyle(context)),
                    TextSpan(
                        text: Strings.spansHome,
                        style: Styles.infoTextStyleHighlighted(context)),
                    TextSpan(
                        text: Strings.orHome,
                        style: Styles.infoTextStyle(context)),
                    TextSpan(
                        text: Strings.factHome,
                        style: Styles.infoTextStyleHighlighted(context)),
                    TextSpan(
                        text: Strings.tapToStartHome,
                        style: Styles.infoTextStyle(context)),
                  ]),
                ),
                const SizedBox(width: 1, height: 36),
                RaisedGradientButton(
                  onPressed: () {
                    _newAdviceBloc.dispatch(LoadNewEvent());
                  },
                  child: Text(Strings.getAnythingButtonHome,
                      style: Styles.buttonTextStyle(context)),
                  gradient: LinearGradient(colors: [
                    Styles.startGradientColor,
                    Styles.endGradientColor
                  ]),
                ),
                const SizedBox(width: 1, height: 36),
                Text(Strings.configureTipHome,
                    textAlign: TextAlign.center,
                    style: Styles.infoTextStyle(context)),
              ],
            ),
          ),
        ),
      );
}
