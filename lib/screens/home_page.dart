import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/post.dart';
import '../components/drawer.dart';
import '../components/newscard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.uid, this.email}) : super(key: key);
  final String title;
  final String uid;
  final String email;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded = false;

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
            : Center(
                child: CircularProgressIndicator(),
              ),
        onRefresh: _fetchData,
      ),
      drawer: Draw(
        title: widget.title,
        uid: widget.uid,
        email: widget.email,
      ),
    );
  }
}
