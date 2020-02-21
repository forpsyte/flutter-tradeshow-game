import 'package:flutter/material.dart';
import 'package:tradeshow/features/game/presentation/pages/game_page.dart';

class SubmissionForm extends StatelessWidget {
  const SubmissionForm({
    Key key,
    @required GlobalKey<FormState> submissionFormKey,
    @required TextEditingController emailController,
    @required TextEditingController nameController,
    @required this.widget,
  })  : _submissionFormKey = submissionFormKey,
        _emailController = emailController,
        _nameController = nameController,
        super(key: key);

  final GlobalKey<FormState> _submissionFormKey;
  final TextEditingController _emailController;
  final TextEditingController _nameController;
  final GamePage widget;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _submissionFormKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 40.0),
            child: Text(
              'Enter your name and email for a chance to win a prize!',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _emailController,
              showCursor: true,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextFormField(
              controller: _nameController,
              showCursor: true,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Row(
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
                  foregroundColor: Colors.red,
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
            ),
          ),
        ],
      ),
    );
  }
}
