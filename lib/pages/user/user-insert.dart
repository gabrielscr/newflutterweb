import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newflutterproject/common/api-service.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/image/image-handler.dart';

class UserInsert extends StatefulWidget {
  @override
  _UserInsertState createState() => _UserInsertState();
}

class _UserInsertState extends State<UserInsert>
    with TickerProviderStateMixin, ImagePickerListener {
  User user = new User();

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: new ListView(
          children: <Widget>[
            new GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: _image == null
                    ? new Stack(
                        children: <Widget>[
                          new Center(
                            child: new CircleAvatar(
                              radius: 80.0,
                              backgroundColor: const Color(0xFF778899),
                            ),
                          ),
                          new Center(
                            child: new Image.asset("assets/img/semfotoperfil.png"),
                          ),
                        ],
                      )
                    : new Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: new ExactAssetImage(_image.path),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.red, width: 5.0),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: 'Qual o seu nome?',
                  labelText: 'Nome',
                  icon: Icon(Icons.person)),
              onChanged: (v) => user.name = v,
            ),
            new TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  hintText: 'Qual o seu e-mail?',
                  labelText: 'E-mail',
                  icon: Icon(Icons.email)),
              onChanged: (v) => user.email = v,
            ),
            new TextField(
              keyboardType: TextInputType.datetime,
              decoration: new InputDecoration(
                  hintText: 'Qual sua data de nascimento?',
                  labelText: 'Data de nascimento',
                  icon: Icon(Icons.date_range)),
              onChanged: (v) => user.birthdate = v,
            ),
            new TextField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                  labelText: 'Salário',
                  prefixText: 'R\$',
                  suffixText: 'Reais',
                  suffixStyle: TextStyle(color: Colors.green),
                  icon: Icon(Icons.attach_money)),
              onChanged: (v) => user.salary = v,
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
    var apiService = new ApiService();

    apiService.post('/api/person/insert', user);

    print(user.toJson());
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
