import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'post.dart';
import 'webview.dart';
import 'package:marquee/marquee.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pocketnews/services/add_bookmark.dart' as addBookmark;
import 'package:pocketnews/services/bookmark_map.dart';

class NewsCard extends StatefulWidget {
  final Post post;
  final bool isBookmark;
  final bool isHomePage;
  NewsCard({this.post, this.isBookmark, this.isHomePage});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isLiked = false;
  bool isBookmarked;
  String savedBookmarkDocId;

  void checkBookmarked() {
    if (widget.isHomePage) {
      isBookmarked = bookmarkMap.containsKey(widget.post.url);
      if (isBookmarked) {
        savedBookmarkDocId = bookmarkMap[widget.post.url];
      }
    } else {
      isBookmarked = widget.isBookmark;
    }
  }

  @override
  void initState() {
    super.initState();
//    print(widget.post);
//    print(widget.isBookmark);
//    print(widget.isHomePage);
    checkBookmarked();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebView(widget.post.url, widget.post.title)),
          );
        },
        child: Column(
          children: <Widget>[
            widget.post.image != null
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.post.image),
                          ),
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.center,
                              colors: [
                                Colors.black.withOpacity(0.55),
                                Colors.black.withOpacity(0.15)
                              ],
                              stops: [
                                0.2,
                                2.0
                              ]),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text(
                            widget.post.title,
                            style: TextStyle(
                                height: 1.25,
                                fontSize: deviceHeight * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: widget.post.name == null
                      ? Container()
                      : Text(
                          widget.post.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold), //, fontSize: deviceHeight * 0.011
                        ),
                ),
                Spacer(),
                widget.post.author != null
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Chip(
                          backgroundColor: Colors.white,
                          avatar: Icon(Icons.edit),
                          label: Container(
                            height: 16.0,
                            constraints:
                                BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.42),
                            child: AutoSizeText(
                              widget.post.author,
                              maxLines: 1,
                              overflowReplacement: Marquee(
                                text: widget.post.author,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                scrollAxis: Axis.horizontal,
                                blankSpace: 20.0,
                                velocity: 50.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: widget.post.publishedAt != null ? Text(widget.post.publishedAt) : Container(),
            ),
            widget.post.description != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.post.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: deviceHeight * 0.02),
                    ),
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(widget.post.url);
                  },
                ),
                Container(
                  child: widget.isHomePage
                      ? (isBookmarked
                          ? IconButton(
                              icon: Icon(Icons.bookmark),
                              onPressed: () {
                                final snackBar = SnackBar(
                                  content: Text('Bookmark deleted'),
                                  duration: Duration(seconds: 1),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                addBookmark.removeData(
                                    documentID: savedBookmarkDocId, bookmarkURL: widget.post.url);
                                print("bookmarkDocumentID: $savedBookmarkDocId");
                                setState(() {
                                  isBookmarked = !isBookmarked;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.bookmark_border),
                              onPressed: () {
                                addBookmark.addData(widget.post);
                                setState(() {
                                  isBookmarked = !isBookmarked;
                                });

                                final snackBar = SnackBar(
                                  content: Text('Bookmark saved'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      String bookmarkDocumentID = addBookmark.newsDocumentID;
                                      addBookmark.removeData(
                                          documentID: bookmarkDocumentID,
                                          bookmarkURL: widget.post.url);
                                      print("bookmarkDocumentID: $bookmarkDocumentID");
                                      setState(() {
                                        isBookmarked = !isBookmarked;
                                      });
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            )) //To add bookmark
                      : (isBookmarked
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                Post post = widget.post;
                                addBookmark.removeData(
                                    documentID: widget.post.documentID,
                                    bookmarkURL: widget.post.url);
                                final snackBar = SnackBar(
                                  content: Text('Bookmark removed'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      addBookmark.addData(post);
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            )
                          : SizedBox()),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}