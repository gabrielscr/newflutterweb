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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 100.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Image.asset('assets/img/logo.png')
              ],
            ),
            SizedBox(height: 50.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
                filled: true,
                labelText: 'Usuário',
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.enhanced_encryption),
                filled: true,
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Voltar'),
                  onPressed: () {},
                ),
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
    );
  }
}
