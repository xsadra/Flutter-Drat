import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 48.0,
          buttonColor: Colors.green[600],
          onPressed: onPressed,
        );
}
