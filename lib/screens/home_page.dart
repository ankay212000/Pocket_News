import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/components/drawer.dart';
import 'package:pocketnews/components/newscard.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.uid, this.email}) : super(key: key);
  final String title;
  final String uid;
  final String email;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded = false;

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;

  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        posts = (data["articles"] as List).map((posts) {
          return Post.fromJSON(posts);
        }).toList();
        setState(() {
          this.isLoaded = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text("Pocket News"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(widget.title),
            textColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        child: this.isLoaded
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsCard(posts[index]);
                },
              )
            : Center(child: CircularProgressIndicator()),
        onRefresh: _fetchData,
      ),
      drawer: Draw(
        title: widget.title,
        uid: widget.uid,
        email: widget.email,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        key: _bottomNavigationKey,
        index: 2,
        items: <Widget>[
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.bookmark,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.bounceIn,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      // ),
    );
  }
}
