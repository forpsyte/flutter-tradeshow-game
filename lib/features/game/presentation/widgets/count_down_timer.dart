import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../pages/game_page.dart';
import 'custom_timer_painter.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({
    Key key,
    @required this.controller,
    @required this.themeData,
    @required this.widget,
    @required this.timerString,
  }) : super(key: key);

  final AnimationController controller;
  final ThemeData themeData;
  final GamePage widget;
  final String timerString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.center,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(
                  painter: CustomTimerPainter(
                    animation: controller,
                    backgroundColor: Colors.white,
                    color: themeData.indicatorColor,
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "visiture",
                      style: TextStyle(
                        fontSize: 60.0,
                        fontFamily: "Varela Round",
                        color: Colors.white,
                      ),
                    ),
                    Observer(
                      builder: (_) => Text(
                        "Clicks: " + widget.store.numClicks.toString(),
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "Varela Round",
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      timerString,
                      style: TextStyle(
                        fontSize: 92.0,
                        fontFamily: "Varela Round",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}