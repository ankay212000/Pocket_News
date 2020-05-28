import 'package:flutter/material.dart';


class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader (
            accountEmail: Text("ankay212000@gmail.com"),
            accountName: Text("ANKAY_21"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text("N"),
              //Image.asset('assets/images/n.jpg'),
            ),
          ),
          InkWell(
            child: ListTile(
              title: Text("Account"),
              leading: Icon(Icons.account_circle),
            ),
            onTap: (){},
          ),
          InkWell(
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings),
            ),
            onTap: (){},
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.help),
              title: Text("Help Center"),
            ),
            onTap: (){},
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
            ),
            onTap: (){},
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
            ),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}