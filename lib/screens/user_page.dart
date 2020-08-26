import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocketnews/screens/login_page.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pocketnews/services/current_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketnews/screens/homeSports.dart';
import 'package:pocketnews/screens/homeScience.dart';
import 'package:pocketnews/screens/homeBusiness.dart';
import 'package:pocketnews/screens/homeHealth.dart';
import 'package:pocketnews/screens/homeTechnology.dart';
import 'package:pocketnews/screens/homeEntertainment.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.controller, this.fname, this.globalKey}) : super(key: key);
  final ScrollController controller;
  GlobalKey globalKey;
  String fname;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<void> send() async {
    final Email email = Email(
      body: "Body",
      subject: "Feedback",
      recipients: ["psocproject@gmail.com"],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final CurvedNavigationBar navigationBar = widget.globalKey.currentWidget;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        controller: widget.controller,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.06),
                          child: CircleAvatar(
                            backgroundColor: Colors.orange[900],
                            child: Center(
                              child: Text(
                                widget.fname[0],
                                style: TextStyle(fontSize: 70.0, color: Colors.white),
                              ),
                            ),
                            // backgroundImage: AssetImage(
                            //   'assets/images/profileimage.png',
                            // ),
                            radius: MediaQuery.of(context).size.height * 0.09,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.fname,
                              style: TextStyle(color: Colors.white, fontSize: 30.0))
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              categoryCard(
                                  "Bussiness", "assests/images/bussiness.jpeg", Icons.business),
                              categoryCard("Entertainment", "assests/images/entertainment.jpeg",
                                  Icons.movie_filter),
                              categoryCard("Health", "assests/images/health.jpeg", Icons.favorite),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              categoryCard(
                                  "Science", "assests/images/science.jpg", Icons.wb_incandescent),
                              categoryCard("Sports", "assests/images/sports.jpeg", Icons.person),
                              categoryCard(
                                  "Technology", "assests/images/technology.jpeg", Icons.devices),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              // size: 15.0,
                            ),
                            title: Text(
                              "Bookmarks",
                              style: TextStyle(
                                color: Colors.white,
                                //fontSize: 12.0
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                            onTap: () {
                              navigationBar.onTap(0);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Feedback",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                            onTap: () {
                              send();
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Signout",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              print("Login Mode: " + loginMode);

                              if (loginMode == "google") {
                                GoogleSignIn googleSignIn = GoogleSignIn();
                                await googleSignIn
                                    .signOut()
                                    .then((value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => LoginPage()),
                                        ))
                                    .catchError((err) => print(err));
                              } else {
                                FirebaseAuth.instance
                                    .signOut()
                                    .then(
                                      (result) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      ),
                                    )
                                    .catchError((err) => print(err));
                              }
//                              navigationBar.onTap(1);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget categoryCard(String categoryName, String image, IconData icons) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          //side: BorderSide(color: Colors.white),
        ),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: (){
                  if(categoryName=="Sports"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageSports(),
                        ));
                }
                 if(categoryName=="Science"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageScience(),
                        ));
                }
                if(categoryName=="Bussiness"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageB(),
                        ));
                }
                if(categoryName=="Entertainment"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageE(),
                        ));
                }
                if(categoryName=="Health"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageH(),
                        ));
                }
                if(categoryName=="Technology"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageT(),
                        ));
                }
                },
                icon: Icon(icons,color: Colors.white,), 
                label:Text(
                '$categoryName',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}