import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/components/newscard.dart';
import 'package:pocketnews/services/current_user.dart' as user;
import 'package:pocketnews/CategoryUrl/health.dart';

class HomePageH extends StatefulWidget {
  HomePageH({
    this.category,
    Key key,
    this.controller,
  }) : super(key: key);
  final ScrollController controller;
  final String category;
  @override
  _HomePageHState createState() => _HomePageHState();
}

class _HomePageHState extends State<HomePageH> {
  //String url = "https://newsapi.org/v2/top-headlines?country=in&category=&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded = false;
  bool isBookmarked = false;
  String _url = kEnglishHURL;
  String _selectedLang = 'English';

  void languageSelect() {
    switch (_selectedLang) {
      case 'English':
        _url = kEnglishHURL;
        break;
      case 'Hindi':
        _url = kHindiHURL;
        break;
      case 'Malayalam':
        _url = kMalayalamHURL;
        break;
      case 'Marathi':
        _url = kMarathiHURL;
        break;
      case 'Tamil':
        _url = kTamilHURL;
        break;
      case 'Telugu':
        _url = kTeluguHURL;
        break;
    }
  }

  Future<void> _fetchData() async {
    try {
      languageSelect();
      print(_url);
      final response = await http.get(_url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        posts = (data["articles"] as List).map((posts) {
          return Post.fromJSON(posts, _selectedLang);
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
    user.loggedInUserID;
    _fetchData();
    //print(widget.email);
    //print(widget.title);
    //print(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Pocket News"),
        centerTitle: true,
        /*actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              elevation: 15,
              value: _selectedLang,
              hint: Text(
                'Platform',
                style: TextStyle(color: Colors.grey),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
              dropdownColor: Colors.black,
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (String value) {
                setState(() {
                  isLoaded = false;
                  _selectedLang = value;
                });
                _fetchData();
              },
              items: <String>['English', 'Hindi', 'Marathi', 'Malayalam', 'Tamil', 'Telugu']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],*/
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
