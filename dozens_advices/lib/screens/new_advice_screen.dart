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
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(Strings.welcomeHome,
                        style: Styles.regularLogoTextStyle(context)),
                    RaisedGradientButton(
                      onPressed: () {},
                      child: Text("Get anything!",
                          style: Styles.buttonTextStyle(context)),
                      gradient: LinearGradient(colors: [
                        Styles.startGradientColor,
                        Styles.endGradientColor
                      ]),
                    ),
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "You may fetch a random "),
                    ]),),

                  ],
                ),
              );
              break;
            default:
              return Container();
          }
        });
  }
}
