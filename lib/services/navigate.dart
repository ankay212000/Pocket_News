import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pocketnews/screens/home_page.dart';
import 'package:pocketnews/screens/user_page.dart';
import 'package:pocketnews/screens/bookmark_page.dart';

class Navigate extends StatefulWidget {
  Navigate({Key key, this.title, this.uid, this.email}) : super(key: key);
  final String title;
  final String uid;
  final String email;
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _selectedPage=1;

  var _pageOptions={
    1:HomePage(url: "https://newsapi.org/v2/top-headlines?country=in&category=&apiKey=ff94394ddcf74eb2be08755e5cd942e9"),
    2:UserPage(),
    0:BookmarkPage(),
    };

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        height: deviceHeight*0.07,
        key: _bottomNavigationKey,
        index: _selectedPage,
        items: <Widget>[
          Icon(
              Icons.bookmark,
              size: 20,
              color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 20,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 20,
            color: Colors.white,
          ),
        ],
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.bounceIn,
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}