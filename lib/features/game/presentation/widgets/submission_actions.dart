import 'package:flutter/material.dart';

import '../pages/game_page.dart';

class SubmissionActions extends StatelessWidget {
  const SubmissionActions({
    Key key,
    @required GlobalKey<FormState> submissionFormKey,
    @required this.widget,
    @required TextEditingController emailController,
    @required TextEditingController nameController,
  })  : _submissionFormKey = submissionFormKey,
        _emailController = emailController,
        _nameController = nameController,
        super(key: key);

  final GlobalKey<FormState> _submissionFormKey;
  final GamePage widget;
  final TextEditingController _emailController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(41, 155, 252, 1.0),
          onPressed: () async {
            if (_submissionFormKey.currentState.validate()) {
              var score = widget.store.numClicks;
              await widget.store.submit(
                email: _emailController.text,
                name: _nameController.text,
                score: score,
              );
              widget.store.gameOver = false;
              widget.store.resetClickCount();
              _emailController.text = '';
              _nameController.text = '';
              Navigator.of(context).pop();
            }
          },
          label: Text(
            'Submit',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: "Varela Round",
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.of(context).pop();
            widget.store.gameOver = false;
            widget.store.resetClickCount();
          },
          label: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: "Varela Round",
            ),
          ),
        )
      ],
    );
  }
}