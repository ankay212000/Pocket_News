import 'package:firebase_auth/firebase_auth.dart';

//class CurrentUser {
String _loggedInUser;
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

String get loggedInUser {
  if (_loggedInUser == null) {
    getCurrentUser().then((value) {
      _loggedInUser = value;
    });
  }
  return _loggedInUser;
}
//}
