import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _fireBaseAuthInstance = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : User(uid: firebaseUser.uid);
  }

  Future<User> currentUser() async {
    final currentUser = await _fireBaseAuthInstance.currentUser();
    return _userFromFirebase(currentUser);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _fireBaseAuthInstance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    await _fireBaseAuthInstance.signOut();
  }
}
