import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocketnews/services/current_user.dart' as user;

final _firestore = Firestore.instance;
String currentUser;

Stream dataStream;
HashMap<String, String> bookmarkMap = HashMap<String, String>();

void getBookmarkStream(String userID) {
  print("Bookmark Stream called");
  currentUser = userID;

  _firestore
      .collection("users")
      .document(currentUser)
      .collection("saves")
      .snapshots()
      .listen((QuerySnapshot snapshot) {
    snapshot.documents.forEach((bookmark) {
      if (!bookmarkMap.containsKey(bookmark.data['url']))
        bookmarkMap[bookmark.data['url']] = bookmark.documentID;
    });
    bookmarkMap.forEach((key, value) {
      print("Bookmark Data " + key + " " + value);
    });
  });
}