import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({@required this.child,this.buttonColor, this.borderRadios,@required this.onPressed});

  final Widget child;
  final Color buttonColor;
  final double borderRadios;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: child,
      color: buttonColor ?? Colors.white30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadios ?? 8.0),),
    );
  }
}
