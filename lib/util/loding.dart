import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() =>
      _LoadingState();
}

class _LoadingState extends State<Loading> {
  var _width = 160.0;
  var _height = 180.0;
  var _opacity = 1.0;
  var _angle = 0.0;
  var _animationDuration = Duration(milliseconds: 700);
  late Color _color = Color(0xFFFFFFFF);
  late double _borderRadius = 0;
  late double _margin = 8;

  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 600), (timer) {
      setState(() {
        _width = _randumValue(max: 200);
        _height = _randumValue(max: 200);
        _color = _randumeColor();
        _borderRadius = _randumValue();
        _margin = _randumValue();
        _angle = _randumValue();
      });
    });
    super.initState();

  }

  double _randumValue({int max = 80}) {
    return Random().nextDouble() * max;
  }

  Color _randumeColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: _animationDuration,
          child: AnimatedContainer(
            duration: _animationDuration,
            width: _width,
            height: _height,
            margin: EdgeInsets.all(_margin),
            //alignment: Alignment.center,
            //transform: Matrix4.identity()..rotateX(_angle),
            transformAlignment: FractionalOffset.center,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
