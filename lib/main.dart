import 'package:flutter/material.dart';
import 'package:newflutterproject/login/login.dart';
import 'package:newflutterproject/pages/home/home-page.dart';
import 'package:newflutterproject/pages/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeebzApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início'),
        centerTitle: true,
      ),
      drawer: Menu(),
      body: HomePage(),
    );
  }
}
