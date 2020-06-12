import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _fireBaseAuthInstance = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : User(uid: firebaseUser.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _fireBaseAuthInstance.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final currentUser = await _fireBaseAuthInstance.currentUser();
    return _userFromFirebase(currentUser);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _fireBaseAuthInstance.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final googleSignInAuth = await googleSignInAccount.authentication;

    if (googleSignInAuth.idToken == null ||
        googleSignInAuth.accessToken == null) {
      throw PlatformException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
        message: 'Missing Google Auth Token',
      );
    }

    final authResult = await _fireBaseAuthInstance.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      ),
    );

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await _fireBaseAuthInstance.signOut();
  }
}
