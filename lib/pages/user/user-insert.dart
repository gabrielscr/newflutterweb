import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';

class UserInsert extends StatefulWidget {
  @override
  _UserInsertState createState() => _UserInsertState();
}

class _UserInsertState extends State<UserInsert> {
  User user = new User();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Inserir usuário'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView(
            children: <Widget>[
              new TextField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                    labelText: 'Nome', icon: Icon(Icons.person)),
                onChanged: (v) => user.name = v,
              ),
              new TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    labelText: 'E-mail', icon: Icon(Icons.email)),
                onChanged: (v) => user.email = v,
              ),
              new TextField(
                keyboardType: TextInputType.datetime,
                decoration: new InputDecoration(
                    labelText: 'Data de nascimento',
                    icon: Icon(Icons.date_range)),
                onChanged: (v) => user.birthdate = v,
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
      ),
    );
  }

  void submit() {
    var apiService = new ApiService();

    apiService.post('/api/person/insert', user);

    print(user.toJson());
  }
}