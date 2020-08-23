import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

String _loggedInUserID;
FirebaseUser currentUser;
final _auth = FirebaseAuth.instance;

Future<String> getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      currentUser = user;
    }
  } catch (e) {
    print(e);
  }
  return currentUser.uid;
}

String get loggedInUserID {
  if (_loggedInUserID == null) {
    getCurrentUser().then((value) {
      _loggedInUserID = value;
    });
  }
  return _loggedInUserID;
}

///SIGN-IN Mode
String loginMode = "";
