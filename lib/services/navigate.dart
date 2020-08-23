import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:pocketnews/screens/home_page.dart';
import 'package:pocketnews/screens/user_page.dart';
import 'package:pocketnews/screens/bookmark_page.dart';

class Navigate extends StatefulWidget {
  Navigate({Key key, this.title, this.uid, this.email,this.fname}) : super(key: key);
  final String title;
  final String uid;
  final String email;
  final String fname;
  @override
  _NavigateState createState() => _NavigateState();
}

int _selectedPage = 1;
GlobalKey bottomNavigationKey = GlobalKey();

class _NavigateState extends State<Navigate> {
  ScrollController _hideBottomNavController = ScrollController();
  bool _isVisible = true;

  @override
  initState() {
    super.initState();
    print(widget.email);
    _hideBottomNavController.addListener(() {
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.reverse) {
        //print("reverse");
        if (_isVisible)
          setState(() {
            _isVisible = false;
          });
      }
      if (_hideBottomNavController.position.userScrollDirection == ScrollDirection.forward) {
        //print("forward");
        if (!_isVisible)
          setState(() {
            _isVisible = true;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    var _pageOptions = {
      0: BookmarkPage(
        controller: _hideBottomNavController,
      ),
      1: HomePage(
        controller: _hideBottomNavController,
      ),
      2: UserPage(
          controller: _hideBottomNavController,
          fname: widget.fname,
          globalKey: bottomNavigationKey),
    };
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: AnimatedContainer(
        //key:bottomNavigationKey,
        duration: Duration(milliseconds: 500),
        height: _isVisible ? 56.0 : 0.0,
        child: Wrap(
          children: <Widget>[
            CurvedNavigationBar(
              color: Colors.black,
              height: _isVisible ? 56.0 : 0.0,
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.black,
              // height: deviceHeight * 0.07,
              key: bottomNavigationKey,
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
          ],
        ),
      ),
    );
  }
}
