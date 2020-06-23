import 'package:flutter/material.dart';
import '../components/check.dart';
import 'dart:async';

class Splashpage extends StatefulWidget {
  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Check())));
  }

  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: deviceheight * 0.225,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(fit: BoxFit.fill, image: AssetImage("assests/images/75Fg.gif"))),
              ),
              SizedBox(
                height: deviceheight * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  "Pocket News",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceheight * 0.009),
                child: Text(
                  "Get News Anywhere,Anytime!!!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: deviceheight * 0.07),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 5,
                ),
              )
            ],
          ),
        ));
  }
}
