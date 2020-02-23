import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tradeshow/features/game/presentation/pages/game_page.dart';

class GameOverMessage extends StatelessWidget {
  const GameOverMessage({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final GamePage widget;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => AnimatedOpacity(
        opacity: widget.store.gameOver ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Text(
          "GAME OVER",
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: "Varela Round",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}