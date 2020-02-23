import 'package:flutter/material.dart';

import '../pages/game_page.dart';
import 'submission_form.dart';

class SubmissionDialog extends Dialog {
  const SubmissionDialog({
    Key key,
    @required this.width,
    @required this.height,
    @required GlobalKey<FormState> submissionFormKey,
    @required TextEditingController emailController,
    @required TextEditingController nameController,
    @required this.widget,
  })  : _submissionFormKey = submissionFormKey,
        _emailController = emailController,
        _nameController = nameController,
        super(key: key);

  final double width;
  final double height;
  final GlobalKey<FormState> _submissionFormKey;
  final TextEditingController _emailController;
  final TextEditingController _nameController;
  final GamePage widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: width < 768 ? height - 150 : 500,
        width: width < 768 ? width : 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SubmissionForm(
              submissionFormKey: _submissionFormKey,
              emailController: _emailController,
              nameController: _nameController,
              widget: widget,
            ),
          ],
        ),
      ),
    );
  }
}
