import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Início'),
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Início',
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: 'Mensagens',
                  icon: Icon(Icons.mail),
                ),
                Tab(
                  text: 'Configurações',
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Text('TESTE', 
              style: TextStyle(fontSize: 50)), 
              Text('Teste2'), 
              Text('Teste3')
              ],
          ),
        ),
      ),
    );
  }
}
