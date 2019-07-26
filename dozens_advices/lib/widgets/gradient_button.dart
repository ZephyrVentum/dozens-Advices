import 'package:dozens_advices/resources/styles.dart';
import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final BorderRadius borderRadius;

  const RaisedGradientButton(
      {Key key,
      @required this.child,
      this.gradient,
      this.width,
      this.height = 50.0,
      this.onPressed,
      this.borderRadius = const BorderRadius.all(Radius.circular(8))})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          highlightColor: Styles.highlightInkWellColor,
          splashColor: Colors.black26,
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: width == null ? EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.all(0),
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
