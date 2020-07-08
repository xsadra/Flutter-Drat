import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({
    @required this.uid,
    @required this.photoUrl,
    @required this.displayName,
    @required this.email,
    @required this.phoneNumber,
  });

  final String uid;
  final String photoUrl;
  final String displayName;
  final String email;
  final String phoneNumber;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<User> signInWithEmailAndPassword({String email, String password});

  Future<User> createUserWithEmailAndPassword({String email, String password});

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _fireBaseAuthInstance = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }

    return User(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoUrl,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
    );
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
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logInWithReadPermissions(
      ['public_profile'],
    );

    if (facebookLoginResult.accessToken == null) {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }

    final authResult = await _fireBaseAuthInstance.signInWithCredential(
      FacebookAuthProvider.getCredential(
        accessToken: facebookLoginResult.accessToken.token,
      ),
    );

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(
      {String email, String password}) async {
    var authResult = await _fireBaseAuthInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      {String email, String password}) async {
    var authResult = await _fireBaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FacebookLogin().logOut();
    await _fireBaseAuthInstance.signOut();
  }
}
