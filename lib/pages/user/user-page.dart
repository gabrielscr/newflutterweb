import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-edit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var users = new List<User>();

  _getUsers() {
    ApiService.listar("person").then((response) {
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
    return Slidable(
      delegate: new SlidableDrawerDelegate(),
      child: Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Usuários'),
            ),
            body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, int index) {
                return new Dismissible(
                  key: new Key(users[index].name),
                  onDismissed: (direction) {
                    users.removeAt(index);
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text('Usuário deletado'),
                    ));
                  },
                  background: new Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: new ListTile(
                      leading: Icon(Icons.person),
                      title: new Text("${users[index].name}"),
                      subtitle: new Text("${users[index].email}"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserEdit(user: users[index])));
                      }),
                );
              },
            )),
      ),
    );
  }
}
