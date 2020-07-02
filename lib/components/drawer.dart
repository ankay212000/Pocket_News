import 'package:flutter/material.dart';


class Draw extends StatefulWidget {
  Draw({Key key, this.title, this.uid, this.email}) : super(key: key);
  final String title;
  final String uid;
  final String email;
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(widget.email),
            accountName: Text(widget.title),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text(
                widget.title.toString()[0],
                style: TextStyle(fontSize: 40.0),
              ),
              //Image.asset('assets/images/n.jpg'),
            ),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Out"),
            ),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
