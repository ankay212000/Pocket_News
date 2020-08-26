import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocketnews/components/newscard.dart';
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/services/current_user.dart' as user;

final _firestore = Firestore.instance;
String currentUser;

class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key key, this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    currentUser = user.loggedInUserID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: NewsCardStream(
          controller: widget.controller,
        ),
      ),
      backgroundColor: Colors.black54,
    );
  }
}

class NewsCardStream extends StatelessWidget {
  NewsCardStream({Key key, this.controller}) : super(key: key);

  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("users").document(currentUser).collection("saves").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Bookmark found'),
          );
        }
        final bookmarks = snapshot.data.documents.reversed;
        List<NewsCard> newsCards = [];
        for (var bookmark in bookmarks) {
          Post post = Post(
            id: bookmark.data['id'],
            name: bookmark.data['name'],
            author: bookmark.data['author'],
            title: bookmark.data['title'],
            description: bookmark.data['description'],
            image: bookmark.data['image'],
            url: bookmark.data['url'],
            publishedAt: bookmark.data['publishedAt'],
            documentID: bookmark.data['documentID'],
          );
          newsCards.add(NewsCard(
            post: post,
            isBookmark: true,
            isHomePage: false,
          ));
        }
        return CustomScrollView(
          controller: controller,
          shrinkWrap: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                newsCards,
              ),
            ),
          ],
        );
      },
    );
  }
}