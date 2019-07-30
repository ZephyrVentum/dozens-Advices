import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAdviceScreen extends StatefulWidget {
  @override
  _NewAdviceScreenState createState() => _NewAdviceScreenState();
}

class _NewAdviceScreenState extends State<NewAdviceScreen> {
  @override
  Widget build(BuildContext context) {
    final NewAdviceBloc newAdviceBloc = BlocProvider.of<NewAdviceBloc>(context);
    return BlocBuilder(
        bloc: newAdviceBloc,
        builder: (BuildContext context, NewAdviceState state) {
          switch (state.runtimeType) {
            case InitialNewAdviceState:
              return buildLoadingState();
              break;
            default:
              return Container();
          }
        });
  }

  Widget buildLoadingState() => Center(
        child: CircularProgressIndicator(value: 0,strokeWidth: 1.75, semanticsLabel: "fdsfs", semanticsValue: "11121",),
      );

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
                  onPressed: () {},
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
