import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocketnews/screens/login_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FlatButton(
            child: Text("Log Out"),
            textColor: Colors.white,
            color: Colors.black54,
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then(
                    (result) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  )
                  .catchError((err) => print(err));
            },
          ),
        ),
      ),
    );
  }
}
