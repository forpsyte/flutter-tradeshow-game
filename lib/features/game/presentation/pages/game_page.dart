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
      duration: Duration(seconds: 1),
    );
    _addListener(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color bgColor = Color.fromRGBO(41, 155, 252, 1.0);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Column(
        children: <Widget>[
          GameMenu(),
          SizedBox(
            height: 10.0,
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Container(
              height: screenWidth < 768 ? 75.0 : 100.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Image.asset('assets/images/logo2.png'),
              ),
            ),
          ),
          GameOverMessage(widget: widget),
          SizedBox(height: 10.0),
          Container(
            width: screenWidth < 768 ? 300 : 600,
            height: screenWidth < 768 ? 300 : 600,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CountDownTimer(
                            controller: controller,
                            themeData: themeData,
                            widget: widget,
                            timerString: timerString,
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          GameControls(controller: controller, widget: widget),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _showSimpleCustomDialog(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SubmissionDialog(
        height: height,
        width: width,
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
