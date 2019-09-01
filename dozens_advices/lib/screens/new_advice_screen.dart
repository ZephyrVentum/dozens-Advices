import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/widgets/gradient_button.dart';
import 'package:dozens_advices/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewAdviceScreen extends StatefulWidget {
  @override
  _NewAdviceScreenState createState() => _NewAdviceScreenState();
}

class _NewAdviceScreenState extends State<NewAdviceScreen> {
  final DateFormat dateFormatter = DateFormat("d MMM yyyy\nh:mm a");
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
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Image(image: AssetImage(getImagePath(advice))),
                            Text(advice.type.substring(1, advice.type.length),
                                style: Styles.infoTextStyleHighlighted(context)
                                    .copyWith(letterSpacing: 1.3, fontSize: 34)),
                          ]),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.today,
                                    color: Styles.averageGradientColor),
                                Text(
                                  Strings.createdAtAdviceHome,
                                  style: Styles.infoTextStyleHighlighted(context)
                                      .copyWith(fontSize: 15),
                                )
                              ],
                            ),
                            Text(
                              dateFormatter
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      advice.createdAt))
                                  .replaceAll("PM", "pm")
                                  .replaceAll("AM", "am"),
                              style: Styles.advicesListDateTextStyle(context),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.visibility,
                                    color: Styles.averageGradientColor),
                                Text(Strings.viewsAdviceHome,
                                    style:
                                        Styles.infoTextStyleHighlighted(context)
                                            .copyWith(fontSize: 15))
                              ],
                            ),
                            Text(advice.views.toString(),
                                style: Styles.advicesListDateTextStyle(context)
                                    .copyWith(fontSize: 20))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.date_range,
                                    color: Styles.averageGradientColor),
                                Text(Strings.lastSeenAdviceHome,
                                    style:
                                        Styles.infoTextStyleHighlighted(context)
                                            .copyWith(fontSize: 15))
                              ],
                            ),
                            Text(
                              dateFormatter
                                  .format(DateTime.fromMicrosecondsSinceEpoch(
                                      advice.viewedAt))
                                  .replaceAll("PM", "pm")
                                  .replaceAll("AM", "am"),
                              style: Styles.advicesListDateTextStyle(context),
                              textAlign: TextAlign.end,
                            )
                          ],
                        )
//            Icon(Icons.date_range)
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        advice.mainContent,
                        style: Theme.of(context)
                            .textTheme
                            .display2
                            .copyWith(fontSize: 35),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Theme.of(context).dividerColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      padding: const EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        RaisedGradientButton(
                          onPressed: () {
                            _newAdviceBloc.dispatch(SpeechAdviceEvent());
                          },
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.black,
                          ),
                          gradient: LinearGradient(colors: [
                            Styles.startGradientColor,
                            Styles.endGradientColor
                          ]),
                        ),
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
                            _newAdviceBloc.dispatch(MarkAsFavouriteEvent(advice));
                          },
                          child: Icon(
                            advice.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: advice.isFavourite
                                ? Colors.red.shade900
                                : Colors.black,
                          ),
                          gradient: LinearGradient(colors: [
                            Styles.startGradientColor,
                            Styles.endGradientColor
                          ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

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
