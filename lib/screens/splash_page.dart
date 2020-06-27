import 'package:flutter/material.dart';
import 'package:pocketnews/services/check.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Check(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assests/images/backg.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.15,
            ),
            Container(
              height: deviceHeight * 0.3,
              width: deviceHeight * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assests/images/75Fg.gif"),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Pocket News",
                style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                    fontFamily: 'Shadows'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * 0.009),
              child: Text(
                "Get News Anywhere,Anytime!!!",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueGrey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * 0.07),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
