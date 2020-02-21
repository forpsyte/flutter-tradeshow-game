import 'package:flutter/material.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: "Varela Round",
              ),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          GestureDetector(
            child: Text(
              "High Scores",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: "Varela Round",
              ),
            ),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/scoreboard');
            },
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }
}