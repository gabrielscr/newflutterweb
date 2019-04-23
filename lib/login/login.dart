import 'package:flutter/material.dart';
import 'package:newflutterproject/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(color: Colors.black),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 120.0),
              Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  new CircleAvatar(
                    backgroundImage: AssetImage('assets/img/admin.png'),
                    radius: 80,
                  )
                ],
              ),
              SizedBox(height: 50.0),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  filled: true,
                  labelText: 'Usuário',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.enhanced_encryption,
                    color: Colors.white,
                  ),
                  filled: true,
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Logar'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
