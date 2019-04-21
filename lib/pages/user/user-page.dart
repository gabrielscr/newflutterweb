import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newflutterproject/pages/user/user-edit.dart';
import 'package:newflutterproject/pages/user/user-insert.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var users = List<dynamic>();

  obterUsuarios() async {
    var response = await UserService().get(
        'api/person/list', {'search': null, 'pageSize': 5000, 'pageIndex': 1});

    setState(() {
      Iterable list = json.decode(response);
      users = list.map((model) => User.fromJson(model)).toList();
    });
  }

  initState() {
    super.initState();
    obterUsuarios();
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
                  excluir(users[index].id);
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
                                  UserEdit(userId: users[index].id)));
                    }),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserInsert()));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void excluir(int id) {
    
    //ApiService apiService = new ApiService();

    //apiService.delete('/api/person/delete', user);
  }
}
