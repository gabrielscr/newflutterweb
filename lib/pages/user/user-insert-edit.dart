import 'dart:io';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/image/image-handler.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserInsertEdit extends StatefulWidget {
  final int userId;
  UserInsertEdit({this.userId});
  @override
  _UserInsertEdit createState() => _UserInsertEdit(userId: this.userId);
}

class _UserInsertEdit extends State<UserInsertEdit>
    with TickerProviderStateMixin, ImagePickerListener {
  final int userId;
  bool _saving = false;

  var user = User();

  var txtName = new TextEditingController();
  var txtEmail = new TextEditingController();
  var txtBirthDate = new TextEditingController();
  var txtUserName = new TextEditingController();
  var txtPassword = new TextEditingController();

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

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    getUser();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _UserInsertEdit({this.userId});

  getUser() async {
    var userFromServer = User();

    if (userId != null) {
      var response =
          await UserService().get('/api/person/get', {'id': this.userId});
      userFromServer = User.fromJson(response);
      txtName.text = userFromServer.name;
      txtEmail.text = userFromServer.email;
      txtBirthDate.text = userFromServer.birthDate;
      txtUserName.text = userFromServer.username;
      txtPassword.text = userFromServer.password;
    }

    setState(() {
      user = userFromServer;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appBarText = this.userId == null ? 'Inserir Usuário' : 'Editar Usuário';

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: ModalProgressHUD(
        progressIndicator: RefreshProgressIndicator(),
        inAsyncCall: _saving,
        child: renderForm()
      ),
    );
  }

  Widget renderForm(){
    final Size screenSize = MediaQuery.of(context).size;

    var fotoPerfil = this.user.image;

    return Form(
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
                                backgroundImage: fotoPerfil == null
                                    ? AssetImage('assets/img/male.png')
                                    : AssetImage(fotoPerfil),
                                backgroundColor: const Color(0xFF778899),
                              ),
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
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(80.0)),
                          ),
                        ),
                ),
              ),
              new TextField(
                keyboardType: TextInputType.text,
                controller: txtName,
                decoration: new InputDecoration(
                    hintText: 'Qual o seu nome?',
                    labelText: 'Nome',
                    icon: Icon(Icons.person)),
                onChanged: (v) => user.name = v,
              ),
              new TextField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                decoration: new InputDecoration(
                    hintText: 'Qual o seu e-mail?',
                    labelText: 'E-mail',
                    icon: Icon(Icons.email)),
                onChanged: (v) => user.email = v,
              ),
              new TextField(
                keyboardType: TextInputType.datetime,
                controller: txtBirthDate,
                decoration: new InputDecoration(
                    hintText: 'Qual sua data de nascimento?',
                    labelText: 'Data de nascimento',
                    icon: Icon(Icons.date_range)),
                onChanged: (v) => user.birthDate = v,
              ),
              Divider(),
              new TextField(
                keyboardType: TextInputType.text,
                controller: txtUserName,
                decoration: new InputDecoration(
                    hintText: 'Escolha um login para acessar o app',
                    labelText: 'Login',
                    icon: Icon(Icons.person_pin)),
                onChanged: (v) => user.username = v,
              ),
              new TextField(
                controller: txtPassword,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                    hintText: 'Escolha uma senha para acessar o app',
                    labelText: 'Senha',
                    icon: Icon(Icons.enhanced_encryption)),
                onChanged: (v) => user.password = v,
                obscureText: true,
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
        );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;

      this.user.image = _image.absolute.path;
    });
  }

  void submit() async {
    setState(() {
      _saving = true;
    });

    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _saving = false;
      });
    });

    if (this.userId == null)
      await UserService().insert('api/person/insert', this.user.toMap());
    else
      await UserService().edit('api/person/edit', this.user.toMap());

    Navigator.pop(context, [true]);
  }
}
