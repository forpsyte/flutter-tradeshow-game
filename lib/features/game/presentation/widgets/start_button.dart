import 'package:flutter/material.dart';

import '../../../score_board/presentation/stores/score_bored_store.dart';

class StartButton extends StatefulWidget {
  final AnimationController controller;
  final ScoreBoardStore store;

  const StartButton({
    Key key,
    @required this.controller,
    @required this.store,
  }) : super(key: key);

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: _onPressed,
      icon: widget.controller.isAnimating ? null : Icon(Icons.play_arrow),
      label: Text(widget.controller.isAnimating ? "Click Me" : "Go"),
    );
  }

  void _onPressed() {
      if (widget.controller.isAnimating) {
        widget.store.incrementClickCount();
      } else {
        widget.store.resetClickCount();
        widget.controller.reverse(
          from:
              widget.controller.value == 0.0 ? 1.0 : widget.controller.value,
        );
      }
    }
}
