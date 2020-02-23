import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: screenWidth < 768 ? MainAxisAlignment.center : MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: 'home',
            icon: Icon(Icons.home),
            label: Text("Home"),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          FloatingActionButton.extended(
            heroTag: 'scoreboard',
            icon: Icon(MdiIcons.trophy),
            label: Text("High Scores"),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/scoreboard');
            },
          ),
        ],
      ),
    );
  }
}