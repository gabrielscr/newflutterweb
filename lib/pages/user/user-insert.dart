import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';

class UserInsert extends StatefulWidget {
  @override
  _UserInsertState createState() => _UserInsertState();
}

class _UserInsertState extends State<UserInsert> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir usuário'),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new ListView(
          children: <Widget>[
            new TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(labelText: 'Nome'),
              controller: TextEditingController(),
            ),
            new TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(labelText: 'E-mail'),
              controller: TextEditingController(),
            ),
            new TextField(
              keyboardType: TextInputType.datetime,
              decoration: new InputDecoration(labelText: 'Data de nascimento'),
              controller: TextEditingController(),
            ),
            new Container(
              width: screenSize.width,
              child: new RaisedButton(
                child: new Text(
                  'Inserir',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: this.submit,
                color: Colors.blue,
              ),
              margin: new EdgeInsets.only(top: 20.0),
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    Map userMap = jsonDecode(jsonString);
    var user = new User.fromJson(userMap);

    String json = jsonEncode(user);
  }
}
