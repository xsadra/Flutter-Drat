import 'package:flutter/material.dart';
import 'package:timetracker/services/auth.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({
    @required this.auth,
    @required this.child,
  });

  final AuthBase auth;
  final Widget child;

  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
