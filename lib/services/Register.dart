import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocketnews/components/modal_progress_indicator.dart';
import 'check.dart';
import 'package:pocketnews/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  bool showSpinner = false;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      indicatorStatus: 'Registering...',
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assests/images/backg.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: deviceHeight * 0.15,
                        width: deviceHeight * 0.15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assests/images/75Fg.gif"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.005),
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 35.0,
                            fontFamily: 'Shadows',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.09,
                  ),
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: firstNameInputController,
                          validator: (value) {
                            if (value.length < 3) {
                              return "Please enter a valid first name. Character>3";
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'First Name*',
                            hintText: "John",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'Email ID*',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                            hintText: "john.doe@gmail.com",
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'Password*',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                            hintText: "********",
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          controller: pwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: 'Confirm Your Password*',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                            hintText: "********",
                            hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          controller: confirmPwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.0189),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text("Register"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_registerFormKey.currentState.validate()) {
                          if (pwdInputController.text == confirmPwdInputController.text) {
                            setState(() {
                              showSpinner = true;
                            });
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                .then(
                                  (currentUser) => Firestore.instance
                                      .collection("users")
                                      .document(currentUser.uid)
                                      .setData({
                                        "uid": currentUser.uid,
                                        "fname": firstNameInputController.text,
                                        "email": emailInputController.text,
                                        "loginMode": "email",
                                      })
                                      .then((result) => {
                                            {
                                              setState(() {
                                                showSpinner = false;
                                              })
                                            },
                                            {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Check()),
                                                  (_) => false),
                                              firstNameInputController.clear(),
                                              lastNameInputController.clear(),
                                              emailInputController.clear(),
                                              pwdInputController.clear(),
                                              confirmPwdInputController.clear(),
                                            }
                                          })
                                      .catchError((err) {
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        showDialog(
                                          context: context,
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
                                          },
                                        );
                                      }),
                                )
                                .catchError(
                              (err) {
                                setState(() {
                                  showSpinner = false;
                                });
                                showDialog(
                                  context: context,
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
                                  },
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("The passwords do not match"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: deviceHeight * 0.05,
                      ),
                      FlatButton(
                        child: Text(
                          "Login here!",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 20,
                              fontFamily: 'Shadows',
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
