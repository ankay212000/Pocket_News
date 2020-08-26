import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocketnews/screens/login_page.dart';
import 'package:pocketnews/services/navigate.dart';
import 'package:pocketnews/services/current_user.dart';
import 'package:pocketnews/services/bookmark_map.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  initState() {
    FirebaseAuth.instance.currentUser().then((currentUser) => {
          if (currentUser == null)
            {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
            }
          else
            {
              Firestore.instance
                  .collection("users")
                  .document(currentUser.uid)
                  .get()
                  .then((DocumentSnapshot result) {
                loginMode = result.data['loginMode'];
                getBookmarkStream(currentUser.uid);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigate(
                      uid: currentUser.uid,
                      email: result.data['email'],
                      fname: result.data['fname'],
                    ),
                  ),
                );
              }).catchError((err) => print(err))
            }
        });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}