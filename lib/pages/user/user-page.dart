import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-insert-edit.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var users = List<dynamic>();
  var user = User();
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    var response = await UserService().get(
        '/api/person/list', {'search': null, 'pageSize': 500, 'pageIndex': 1});

    setState(() {
      users = response.map((model) => User.fromJson(model)).toList();
    });
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
      appBar: AppBar(title: Text('Users')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: users[index].image == null
                  ? AssetImage('assets/img/male.png')
                  : AssetImage(users[index].image),
            ),
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
            trailing: IconButton(
                icon: new Icon(Icons.delete),
                color: Colors.red,
                onPressed: () async {
                  await deleteUser(users[index].id);
                }),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserInsertEdit(userId: users[index].id))).then((val) {
                if (val != null && val.isNotEmpty) getUsers();
              });
            },
          );
        },
      ),
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
