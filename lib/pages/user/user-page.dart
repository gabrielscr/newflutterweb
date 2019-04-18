import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-edit.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var users = new List<User>();

  _getUsers() {
    ApiService.httpList("person").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuários'),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(users[index].name),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserEdit(user: users[index])));
              },
            );
          },
        ));
  }
}
