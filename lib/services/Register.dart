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
    lastNameInputController = new TextEditingController();
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
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: deviceHeight * 0.7),
                child: Container(
                  height: deviceHeight * 0.118,
                  width: deviceHeight * 0.118,
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
                padding: EdgeInsets.only(bottom: deviceHeight * 0.50),
                child: Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: deviceHeight * 0.02, left: deviceHeight * 0.02, top: deviceHeight * 0.2),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(deviceHeight * 0.023),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'First Name*', hintText: "John"),
                            controller: firstNameInputController,
                            validator: (value) {
                              if (value.length < 3) {
                                return "Please enter a valid first name. Character>3";
                              }
                            },
                          ),
                          TextFormField(
                              decoration: InputDecoration(labelText: 'Last Name*', hintText: "Doe"),
                              controller: lastNameInputController,
                              validator: (value) {
                                if (value.length < 3) {
                                  return "Please enter a valid last name. Character>3";
                                }
                              }),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Email*', hintText: "john.doe@gmail.com"),
                            controller: emailInputController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password*', hintText: "********"),
                            controller: pwdInputController,
                            obscureText: true,
                            validator: pwdValidator,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Confirm Password*', hintText: "********"),
                            controller: confirmPwdInputController,
                            obscureText: true,
                            validator: pwdValidator,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.0189),
                            child: RaisedButton(
                              child: Text("Register"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                });

                                if (_registerFormKey.currentState.validate()) {
                                  if (pwdInputController.text == confirmPwdInputController.text) {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailInputController.text, password: pwdInputController.text)
                                        .then(
                                          (currentUser) => Firestore.instance
                                              .collection("users")
                                              .document(currentUser.uid)
                                              .setData({
                                                "uid": currentUser.uid,
                                                "fname": firstNameInputController.text,
                                                "surname": lastNameInputController.text,
                                                "email": emailInputController.text,
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
                                    setState(() {
                                      showSpinner = false;
                                    });
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
                          Text("Already have an account?"),
                          FlatButton(
                            child: Text("Login here!"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                          )
                        ],
                      ),
                    )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
