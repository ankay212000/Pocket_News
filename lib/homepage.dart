import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:updateme/post.dart';
import 'package:updateme/drawer.dart';
import 'package:updateme/newscard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:updateme/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded =false;

  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);
      if(response.statusCode==200){
        final data = json.decode(response.body);
        posts = (data["articles"] as List).map((posts) {
          return Post.fromJSON(posts);
        }).toList();
        setState(() {
          this.isLoaded =true;
        });
      }
    } catch(e) {
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
            child: Text("Log Out"),
            textColor: Colors.white,
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((result) =>
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()
                                  )))
                  .catchError((err) => print(err));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        child: this.isLoaded ? ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context,int index) {
            return NewsCard(posts[index]);
          },
        ): Center(child: CircularProgressIndicator()),
        onRefresh: _fetchData,
      ),
      drawer: Draw(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark,color: Colors.white,),
              title: Text("Your Save",style: TextStyle(color: Colors.white),)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity,color: Colors.white,),
              title: Text("You",style: TextStyle(color: Colors.white),)
          )
        ],
        elevation: 3,
        backgroundColor: Colors.black,
      ),
    );
  }
}