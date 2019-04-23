import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-insert-edit.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  StreamController _userController;

  @override
  void initState() {
    _userController = new StreamController();
    loadUsers();
    super.initState();
  }

  Future getUsers() async {
    List<dynamic> users = [];
    var response = await UserService().get(
        '/api/user/list', {'search': null, 'pageSize': 1000, 'pageIndex': 1});

    if (mounted) {
      setState(() {
        users = response.map((model) => User.fromJson(model)).toList();
      });
    }

    return users;
  }

  loadUsers() {
    getUsers().then((res) async {
      _userController.add(res);
      return res;
    });
  }

  deleteUser(int userId) async {
    executeDelete() async {
      await UserService().delete('api/user/delete', {'id': userId});
      await loadUsers();
      Navigator.of(context).pop();
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Deseja realmente excluir?'),
            content: Text('Esta ação não pode ser desfeita'),
            actions: <Widget>[
              new FlatButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text('Excluir'),
                textColor: Colors.red,
                onPressed: () async {
                  await executeDelete();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuários')),
      body: StreamBuilder(
          stream: _userController.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: snapshot.data[index].profileImage == null
                          ? AssetImage('assets/img/male.png')
                          : AssetImage(snapshot.data[index].profileImage),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    trailing: IconButton(
                        icon: new Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          await deleteUser(snapshot.data[index].id);
                        }),
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInsertEdit(
                                      userId: snapshot.data[index].id)))
                          .then((val) {
                        if (val != null) loadUsers();
                      });
                    },
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInsertEdit(userId: null)))
              .then((val) {
            if (val != null) loadUsers();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
