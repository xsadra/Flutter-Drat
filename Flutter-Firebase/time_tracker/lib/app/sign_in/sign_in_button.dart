import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(textColor != null),
        assert(color != null),
        super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
          buttonColor: color,
          height: 48.0,
          onPressed: onPressed,
        );
}
