import 'package:flutter/material.dart';
import 'package:pocketnews/services/check.dart';
import 'dart:async';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 6), vsync: this);
    playAnimation();
  }

  Future<void> playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Check(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StaggerAnimation(controller: _controller.view),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller})
      : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        width = Tween<double>(
          begin: 500.0,
          end: 200.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.00,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 500.0,
          end: 200.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.00,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.blue,
          end: Colors.lightBlueAccent,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.300,
              0.600,
            ),
          ),
        ),
        textLength = Tween<double>(
          begin: 0,
          end: 11,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.300,
              0.600,
              curve: Curves.ease,
            ),
          ),
        ),
        textLength2 = Tween<double>(
          begin: 0,
          end: "Get News Anywhere,Anytime!!!".length.toDouble(),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.600,
              0.900,
              curve: Curves.ease,
            ),
          ),
        ),
        sizedBoxHeight = Tween<double>(
          begin: 50,
          end: 0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.300,
              0.900,
              curve: Curves.ease,
            ),
          ),
        ),
        one = Tween<int>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.300,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        two = Tween<int>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.600,
              0.600,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<double> textLength;
  final Animation<double> textLength2;
  final Animation<double> sizedBoxHeight;
  final Animation<int> one;
  final Animation<int> two;
  final Animation<Color> color;

  static const TEXT_STYLE = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      fontFamily: 'Shadows',
      color: Colors.lightBlueAccent);
  static const TEXT_STYLE2 = TextStyle(fontSize: 20.0, color: Colors.blueGrey);

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: sizedBoxHeight.value,
        ),
        Opacity(
          opacity: opacity.value,
          child: Container(
            height: height.value,
            width: width.value,
            child: CircleAvatar(
              backgroundImage: AssetImage("assests/images/75Fg.gif"),
              radius: 200,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pocket News".substring(0, textLength.value.toInt()),
                style: TEXT_STYLE),
            one.value == 1 ? _blinkingCursor(TEXT_STYLE) : Container(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Get News Anywhere,Anytime!!!"
                    .substring(0, textLength2.value.toInt()),
                style: TEXT_STYLE2),
            two.value == 1 ? _blinkingCursor(TEXT_STYLE2) : Container(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _blinkingCursor(TextStyle textStyle) {
    return LoopAnimation<int>(
      duration: 600.milliseconds,
      tween: 0.tweenTo(1),
      builder: (context, child, oneOrZero) {
        return Opacity(
            opacity: oneOrZero == 1 ? 1.0 : 0.0,
            child: Text("_", style: textStyle));
      },
    );
  } 
}
