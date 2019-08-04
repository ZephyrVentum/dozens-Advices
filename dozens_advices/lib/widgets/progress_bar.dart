import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 8), vsync: this)
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image(image: AssetImage("assets/images/inner_circle.png")),
        AnimatedBuilder(
            animation: animation,
            child: Image(image: AssetImage("assets/images/outer_circle.png")),
            builder: (context, child) {
              return Transform.rotate(angle: animation.value, child: child);
            })
      ],
    );
  }
}
