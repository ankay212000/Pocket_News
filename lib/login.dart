import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage.dart';
import 'Register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height.roundToDouble();
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
        ),
        body: Stack(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: deviceHeight*0.7),
                child: Container(
                  height: deviceHeight*0.118,
                  width: deviceHeight*0.118,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assests/images/75Fg.gif")
                      )
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom:deviceHeight*0.4),
                child: Text("User Login", style: TextStyle(color: Colors.white,fontSize: 40.0),),
              ),),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: deviceHeight*0.01,left: deviceHeight*0.01),
                child: Padding(
                  padding: EdgeInsets.only(top:deviceHeight*0.11),                // by mistake i have added padding inside padding 
                  child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(deviceHeight*0.023),
                  child: SingleChildScrollView(
                      child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                              labelText: 'Email*' , hintText: "john.doe@gmail.com"),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password*', hintText: "********"),
                          controller: pwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:deviceHeight*0.018),
                          child: RaisedButton(
                            child: Text("Login"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if (_loginFormKey.currentState.validate()) {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                    .then((currentUser) => Firestore.instance
                                    .collection("users")
                                    .document(currentUser.uid)
                                    .get()
                                    .then((DocumentSnapshot result) =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                              title: result['fname'],
                                              uid: currentUser.uid,
                                              email: emailInputController.text,
                                            ))))
                                    .catchError((err) => showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(err.toString()),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })))
                                    .catchError((err) => showDialog(context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(err.toString()),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }));
                              }
                            },
                          ),
                        ),
                        Text("Don't have an account yet?"),
                        FlatButton(
                          child: Text("Register here!"),
                          onPressed: () {
                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()
                                        ));
                          },
                        )
                      ],
                    ),
                  ))),
                ),
              ),)
          ],)
        );
  }
}