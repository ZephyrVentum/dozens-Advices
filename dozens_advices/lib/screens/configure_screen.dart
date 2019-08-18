import 'package:flutter/material.dart';

class ConfigureScreen extends StatefulWidget {
  @override
  _ConfigureScreenState createState() => _ConfigureScreenState();
}

class _ConfigureScreenState extends State<ConfigureScreen> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }),
        Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }),
        Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }),
        Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }),
        Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            })
      ],
    );
  }
}
