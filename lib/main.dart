import 'package:flutter/material.dart';
import 'screens/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Update Me",
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
    );
  }
}
