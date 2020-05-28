import 'package:flutter/material.dart';
import 'file:///C:/Users/nktum/AndroidStudioProjects/updateme/lib/splashpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Update Me",
      debugShowCheckedModeBanner: false,
      home: Splashpage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
    );
  }
}