import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../pages/game_page.dart';
import 'start_button.dart';

class GameControls extends StatelessWidget {
  const GameControls({
    Key key,
    @required this.controller,
    @required this.widget,
  }) : super(key: key);

  final AnimationController controller;
  final GamePage widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Observer(
          builder: (_) {
            if (widget.store.gameOver) {
              return SizedBox(
                height: 48,
              );
            } else {
              return StartButton(
                controller: controller,
                store: widget.store,
              );
            }
          },
        );
      },
    );
  }
}