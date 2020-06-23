import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/screens/login_page.dart';
import 'package:news/screens/home_page.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  initState() {
    FirebaseAuth.instance.currentUser().then(
          (currentUser) => {
            if (currentUser == null)
              {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()))}
            else
              {
                Firestore.instance
                    .collection("users")
                    .document(currentUser.uid)
                    .get()
                    .then((DocumentSnapshot result) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  title: result["fname"],
                                  email: currentUser.email,
                                ))))
                    .catchError((err) => print(err))
              }
          },
        );
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
