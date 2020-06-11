import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton{
  SignInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed
  }): super(
    child: Text(
      text,
      style: TextStyle(color: textColor,fontSize: 15.0,),
    ),
    buttonColor: color,
    height:48.0,
    onPressed: onPressed,
  );
}