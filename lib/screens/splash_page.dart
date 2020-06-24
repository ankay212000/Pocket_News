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
              height: deviceHeight * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Pocket News",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * 0.009),
              child: Text(
                "Get News Anywhere,Anytime!!!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
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
