import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';

class UserEdit extends StatelessWidget {
  final User user;

  UserEdit({Key key, @required this.user}) : super(key: key);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar usuário'),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Form(
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.text,
                controller: TextEditingController(text: user.name),
                decoration: new InputDecoration(labelText: 'Nome'),
                onSaved: (String value) {
                  this.user.name = value;
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                controller: TextEditingController(text: user.email),
                decoration: new InputDecoration(labelText: 'E-mail'),
                onSaved: (String value) {
                  this.user.email = value;
                },
              ),
              new Container(
                width: screenSize.width,
                child: new RaisedButton(
                  child: new Text(
                    'Editar',
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
      ),
    );
  }

  void submit() {
    // First validate form
    _formKey.currentState.save(); // Save our form now.

    ApiService.editar("person", this.user.id);
  }
}
