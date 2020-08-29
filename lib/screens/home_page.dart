import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/components/newscard.dart';
import 'package:pocketnews/services/current_user.dart' as user;
import 'package:pocketnews/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    this.controller,
  }) : super(key: key);
  final ScrollController controller;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String url = "https://newsapi.org/v2/top-headlines?country=in&category=&apiKey=ff94394ddcf74eb2be08755e5cd942e9";
  List<Post> posts = List();
  bool isLoaded = false;
  bool isBookmarked = false;
  String _url = kEnglishURL;
  String _selectedLang = 'English';

  void languageSelect() {
    switch (_selectedLang) {
      case 'English':
        _url = kEnglishURL;
        break;
      case 'Hindi':
        _url = kHindiURL;
        break;
      case 'Malayalam':
        _url = kMalayalamURL;
        break;
      case 'Marathi':
        _url = kMarathiURL;
        break;
      case 'Tamil':
        _url = kTamilURL;
        break;
      case 'Telugu':
        _url = kTeluguURL;
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
