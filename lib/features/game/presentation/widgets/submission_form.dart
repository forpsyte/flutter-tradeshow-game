import 'package:flutter/material.dart';

import '../pages/game_page.dart';
import 'submission_actions.dart';
import 'submission_actions_mobile.dart';

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
    final width = MediaQuery.of(context).size.width;
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _emailController,
              style: TextStyle(color: Theme.of(context).primaryColor),
              showCursor: true,
              cursorColor: Color.fromRGBO(41, 155, 252, 1.0),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Color.fromRGBO(41, 155, 252, 1.0),
                  ),
                  labelText: 'E-mail',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(41, 155, 252, 1.0))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: _nameController,
              style: TextStyle(color: Theme.of(context).primaryColor),
              showCursor: true,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(41, 155, 252, 1.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(41, 155, 252, 1.0),
                  ),
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Color.fromRGBO(41, 155, 252, 1.0))),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 30,
            ),
            child: width < 768 ? getMobileActions() : getWebActions(),
          ),
        ],
      ),
    );
  }

  Widget getMobileActions() {
    return SubmissionActionsMobile(
      submissionFormKey: _submissionFormKey,
      widget: widget,
      emailController: _emailController,
      nameController: _nameController,
    );
  }

  Widget getWebActions() {
    return SubmissionActions(
      submissionFormKey: _submissionFormKey,
      widget: widget,
      emailController: _emailController,
      nameController: _nameController,
    );
  }
}
