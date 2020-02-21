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
        accentColor: Color.fromRGBO(255, 74, 109, 1.0),
      ),
      routes: {
        '/scoreboard': (context) => Consumer<ScoreBoardStore>(
              builder: (context, value, _) => ScoreBoardPage(value),
            ),
      },
    );
  }
}
