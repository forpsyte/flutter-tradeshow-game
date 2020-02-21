import 'package:flutter/material.dart';

import '../../../score_board/presentation/stores/score_bored_store.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/game_controls.dart';
import '../widgets/game_menu.dart';
import '../widgets/game_over_message.dart';
import '../widgets/submission_dialog.dart';

class GamePage extends StatefulWidget {
  final ScoreBoardStore store;

  const GamePage({
    @required this.store,
    Key key,
  }) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  AnimationController controller;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _submissionFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    _addListener(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 155, 252, 1.0),
      body: Column(
        children: <Widget>[
          GameMenu(),
          Expanded(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Color.fromRGBO(41, 155, 252, 1.0),
                        height: controller.value *
                            MediaQuery.of(context).size.height,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GameOverMessage(widget: widget),
                          SizedBox(height: 40.0),
                          CountDownTimer(
                            controller: controller,
                            themeData: themeData,
                            widget: widget,
                            timerString: timerString,
                          ),
                          SizedBox(height: 40.0),
                          GameControls(controller: controller, widget: widget),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _showSimpleCustomDialog(BuildContext context) {
    final size = MediaQuery.of(context).size.height / 2;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SubmissionDialog(
        size: size,
        submissionFormKey: _submissionFormKey,
        emailController: _emailController,
        nameController: _nameController,
        widget: widget,
      ),
    );
  }

  void _addListener(BuildContext context) {
    controller.reset();
    controller.addListener(() {
      if (controller.isDismissed) {
        widget.store.gameOver = true;
        _showSimpleCustomDialog(context);
      }
    });
  }
}
