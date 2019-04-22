import 'package:flutter/material.dart';
import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:newflutterproject/pages/produto/produto-page.dart';
import 'package:newflutterproject/pages/user/user-list.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Gabriel Rocha'),
            accountEmail: Text('gabrielscrocha4@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile/profile.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Boxicons.bxBox),
            title: Text('Produtos'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProdutoPage()));
            },
          ),
          ListTile(
            leading: Icon(Boxicons.bxPurchaseTag),
            title: Text('Marcas'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProdutoPage()));
            },
          ),
          ListTile(
            leading: Icon(Boxicons.bxTruck),
            title: Text('Estoque'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProdutoPage()));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Boxicons.bxUser),
            title: Text('Usuários'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserList()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserList()));
            },
          ),
        ],
      ),
    );
  }
}
