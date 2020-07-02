import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/components/newscard.dart';
import 'package:pocketnews/services/current_user.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocketnews/screens/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.url, this.controller}) : super(key: key);
  final String url;
  final ScrollController controller;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String url = "https://newsapi.org/v2/top-headlines?country=in&category=&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded = false;
  bool isBookmarked = false;

  Future<void> _fetchData() async {
    try {
      print(widget.url);
      final response = await http.get(widget.url);
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
    user.loggedInUser;
    _fetchData();
    //print(widget.email);
    //print(widget.title);
    //print(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pocket News"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Log Out"),
            textColor: Colors.white,
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then(
                    (result) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  )
                  .catchError((err) => print(err));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        child: this.isLoaded
            ? CustomScrollView(
                controller: widget.controller,
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.all(2.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return NewsCard(
                            post: posts[index],
                            isBookmark: false,
                            isHomePage: true,
                          );
                        },
                        childCount: posts.length,
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
        onRefresh: _fetchData,
      ),
    );
  }
}
