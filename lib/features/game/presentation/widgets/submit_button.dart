import 'package:flutter/material.dart';
import 'package:tradeshow/features/score_board/presentation/stores/score_bored_store.dart';

class SubmitButton extends StatelessWidget {

  const SubmitButton({
    Key key,
    @required this.controller,
    @required this.store,
  }) : super(key: key);

  final AnimationController controller;
  final ScoreBoardStore store;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: _onPressed,
      label: Text("Submit"),
    );
  }

  void _onPressed() {
    // TODO: Implement page navigation
  }
}
