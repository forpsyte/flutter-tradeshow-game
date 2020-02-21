import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/score_board/presentation/stores/score_bored_store.dart';
import '../../injection_container.dart';
import 'themeable_navigation_app.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ScoreBoardStore>(
          create: (_) => sl<ScoreBoardStore>(),
        ),
      ],
      child: Consumer<ScoreBoardStore>(
        builder: (context, value, _) => ThemeableNavigationApp(),
      ),
    );
  }
}