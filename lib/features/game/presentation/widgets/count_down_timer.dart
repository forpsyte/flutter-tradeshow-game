import 'package:auto_size_text/auto_size_text.dart';
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
                child: Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Observer(
                        builder: (_) => AutoSizeText(
                          "Clicks: " + widget.store.numClicks.toString(),
                          style: Theme.of(context).textTheme.headline3,
                          minFontSize: 10.0,
                          maxLines: 1,
                        ),
                      ),
                      AutoSizeText(
                        timerString,
                        style: Theme.of(context).textTheme.headline3,
                        minFontSize: 10.0,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
