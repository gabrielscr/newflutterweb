import 'package:flutter/material.dart';
import 'package:newflutterproject/pages/home/home-page.dart';
import 'package:newflutterproject/pages/user/user-page.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('MENU'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.phone_iphone),
            title: Text('Início'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Usuários'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
          ),
        ],
      ),
    );
  }
}
