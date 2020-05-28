import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:updateme/post.dart';
import 'file:///C:/Users/nktum/AndroidStudioProjects/updateme/lib/webview.dart';

class NewsCard extends StatefulWidget {

  final Post post;

  NewsCard(this.post);


  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  bool isLiked = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
        elevation: 3,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>WebView(widget.post.url, widget.post.title)
                  )
              );
            },
            child: Column(
              children: <Widget>[
                widget.post.image !=null ?
                Stack(
                  children: <Widget>[
                    Container(
                      height: deviceHeight*0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.post.image)
                          )
                      ),
                    ),
                    Container(
                      height: deviceHeight*0.3,
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
                              ]
                          )
                      ),
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text(
                              widget.post.title,
                              style: TextStyle(
                                  height: 1.25,
                                  fontSize: deviceHeight*0.03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )
                          )
                      ),
                    ),
                  ],
                ): SizedBox(),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          widget.post.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: deviceHeight*0.011
                          )
                      ),
                    ),
                    Spacer(),
                    widget.post.author !=null
                        ?
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Chip(
                        backgroundColor: Colors.white,
                        avatar: Icon(Icons.edit),
                        label: Text(widget.post.author),
                      ),
                    )
                        :SizedBox()
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0,bottom: 8.0),
                  child: Text(widget.post.publishedAt),
                ),
                widget.post.description !=null
                    ?
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.post.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: deviceHeight*0.02),
                    )
                ) : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: this.isLiked
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      onPressed: (){
                        final snackBar =SnackBar(
                          content: Text("Added to favorite"),
                          action: SnackBarAction(
                            label : 'Undo',
                            onPressed: (){
                              setState(() {
                                this.isLiked = !this.isLiked;
                              });
                            },
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        setState(() {
                          this.isLiked = !this.isLiked;
                        });
                      },
                    ),
                    IconButton(
                      icon: this.isBookmarked
                          ? Icon(Icons.bookmark)
                          : Icon(Icons.bookmark_border),
                      onPressed: (){
                        final snackBar =SnackBar(
                          content: Text("Bookmark Added"),
                          action: SnackBarAction(
                            label : 'Undo',
                            onPressed: (){
                              setState(() {
                                this.isBookmarked = !this.isBookmarked;
                              });
                            },
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        setState(() {
                          this.isBookmarked = !this.isBookmarked;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(widget.post.url);
                      },
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}