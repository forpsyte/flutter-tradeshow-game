import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../game/presentation/widgets/game_menu.dart';
import '../stores/score_bored_store.dart';

class ScoreBoardPage extends StatefulWidget {
  ScoreBoardPage(this.store, {Key key}) : super(key: key);

  final ScoreBoardStore store;

  @override
  _ScoreBoardPageState createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.store.loadInitialPlayers();
  }

  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    super.build(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 155, 252, 1.0),
      body: Column(
        children: <Widget>[
          GameMenu(),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(
              "Top Players",
              style: TextStyle(
                fontFamily: "Varela Round",
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Observer(
            builder: (_) {
              switch (widget.store.loadPlayersFuture.status) {
                case FutureStatus.rejected:
                  return Container(
                    child: Text(
                      "Error",
                    ),
                  );
                case FutureStatus.fulfilled:
                  return Expanded(
                    child: ListView.builder(
                      itemCount: widget.store.collection.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    widget.store.collection[index].name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.width / 40,
                                      fontFamily: "Varela Round",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    widget.store.collection[index].score
                                        .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context).size.width / 40,
                                      fontFamily: "Varela Round",
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                case FutureStatus.pending:
                default:
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
