import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-insert-edit.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  getUsers() async {
    List<dynamic> users = [];
    var response = await UserService().get(
        '/api/person/list', {'search': null, 'pageSize': 500, 'pageIndex': 1});

    if (this.mounted) {
      setState(() {
        users = response.map((model) => User.fromJson(model)).toList();
      });
    }

    return users;
  }

  deleteUser(int userId) async {
    executeDelete() async {
      await UserService().delete('api/person/delete', {'id': userId});
      await getUsers();
      Navigator.of(context).pop();
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete user'),
            content: Text('This action cannot be undone'),
            actions: <Widget>[
              new FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text('Delete'),
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
      body: Container(
          child: FutureBuilder(
              future: getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                          backgroundImage: snapshot.data[index].image == null
                              ? AssetImage('assets/img/male.png')
                              : AssetImage(snapshot.data[index].image),
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
                            if (val != null && val.isNotEmpty) getUsers();
                          });
                        },
                      );
                    },
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInsertEdit(userId: null)))
              .then((val) {
            if (val != null && val.isNotEmpty) getUsers();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
