import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocketnews/components/post.dart';
import 'package:pocketnews/services/current_user.dart' as user;
import 'package:pocketnews/services/bookmark_map.dart';

String _newsDocumentID;
String get newsDocumentID {
  return _newsDocumentID;
}

//class Bookmark {
void addData(Post post) {
  String currentUser = user.loggedInUserID;
  if (currentUser == null) {
    print("Login again");
    return null;
  }
  print("Bookmark Triggered for $currentUser");
  print(post.publishedAt);
  Firestore.instance
      .collection("users")
      .document(currentUser)
      .collection("saves")
      .add({}).then((docRef) {
    Firestore.instance
        .collection("users")
        .document(currentUser)
        .collection("saves")
        .document(docRef.documentID)
        .setData({
      "pid": post.id,
      "name": post.name,
      "author": post.author,
      "title": post.title,
      "description": post.description,
      "url": post.url,
      "image": post.image,
      "publishedAt": post.publishedAt,
      "documentID": docRef.documentID,
    });
    _newsDocumentID = docRef.documentID;
    print(_newsDocumentID);
  });
}

void removeData({String documentID, String bookmarkURL}) {
  String currentUser = user.loggedInUserID;
  if (currentUser == null) {
    print("Login again");
    return;
  }
  print("Document ID received: $documentID");
  Firestore.instance
      .collection("users")
      .document(currentUser)
      .collection("saves")
      .document(documentID)
      .delete()
      .then((value) {
    print("Bookmark deleted.");
    bookmarkMap.remove(bookmarkURL);
  });
}
//}