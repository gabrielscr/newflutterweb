import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';

class UserEdit extends StatelessWidget {

  final User user;

  UserEdit({Key key, @required this.user}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(user.name + ' - ' + user.email),
      ),
    );
  }
}