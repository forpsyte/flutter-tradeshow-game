import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradeshow/features/game/presentation/pages/game_page.dart';
import 'package:tradeshow/features/score_board/presentation/pages/score_board_page.dart';

import '../../features/score_board/presentation/stores/score_bored_store.dart';

class ThemeableNavigationApp extends StatelessWidget {
  ThemeableNavigationApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visture Trade Show',
      home: Consumer<ScoreBoardStore>(
        builder: (context, value, _) => GamePage(
          store: value,
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        primaryColor: Color.fromRGBO(41, 155, 252, 1.0),
        accentColor: Color.fromRGBO(255, 74, 109, 1.0),
        dialogBackgroundColor: Color.fromRGBO(27, 44, 70, 1.0),
        textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(27, 44, 70, 1.0),
            ),
            headline1: TextStyle(
              fontSize: 80.0,
              color: Color.fromRGBO(27, 44, 70, 1.0),
            ),
            headline2: TextStyle(
              fontSize: 40.0,
              color: Color.fromRGBO(27, 44, 70, 1.0),
            ),
            headline3: TextStyle(
              fontSize: 30.0,
              color: Color.fromRGBO(27, 44, 70, 1.0),
            ),
            headline5: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(27, 44, 70, 1.0),
            )),
        fontFamily: "Varela Round",
      ),
      routes: {
        '/scoreboard': (context) => Consumer<ScoreBoardStore>(
              builder: (context, value, _) => ScoreBoardPage(value),
            ),
      },
    );
  }
}
