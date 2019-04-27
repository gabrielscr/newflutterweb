import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:newflutterproject/common/handle-change.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/image/image-handler.dart';
import 'package:newflutterproject/pages/user/user-list.dart';
import 'package:newflutterproject/pages/user/user-service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserInsertEdit extends StatefulWidget {
  final int userId;
  UserInsertEdit({this.userId});
  @override
  _UserInsertEdit createState() => _UserInsertEdit(userId: this.userId);
}

class _UserInsertEdit extends State<UserInsertEdit>
    with TickerProviderStateMixin, ImagePickerListener {
  final int userId;

  var user = User();

  File _image;
  AnimationController _controller;
  Animation _animation;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => getUser());
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

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
          await UserService().get('/api/user/get', {'id': this.userId});
      userFromServer = User.fromJson(response);
      handleChange.setValue(userFromServer.toMap());
    }

    if (mounted) {
      setState(() {
        user = userFromServer;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  var handleChange = HandleChange();

  @override
  Widget build(BuildContext context) {
    var appBarText = this.userId == null ? 'Inserir Usuário' : 'Editar Usuário';
    _controller.forward();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Container(
        child: renderForm(),
      ),
    );
  }

  Widget renderForm() {
    var fotoPerfil = this.user.profileImage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: new ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            new GestureDetector(
              onTap: () => imagePicker.showDialog(context),
              child: new Center(
                child: _image == null
                    ? new Stack(
                        children: <Widget>[
                          new Center(
                            child: FadeTransition(
                              opacity: _animation,
                              child: new CircleAvatar(
                                radius: 80.0,
                                backgroundImage: fotoPerfil == null
                                    ? AssetImage('assets/img/male.png')
                                    : AssetImage(fotoPerfil),
                                backgroundColor: const Color(0xFF778899),
                              ),
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
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              controller: handleChange.add('name'),
              enabled: handleChange.addDisabled('name'),
              decoration: new InputDecoration(
                  labelText: 'Nome', icon: Icon(Icons.person)),
              onChanged: (v) => user.name = v,
            ),
            new TextField(
              keyboardType: TextInputType.text,
              controller: handleChange.add('lastName'),
              enabled: handleChange.addDisabled('lastName'),
              decoration: new InputDecoration(
                  labelText: 'Último nome', icon: Icon(Icons.person)),
              onChanged: (v) => user.lastName = v,
            ),
            new TextField(
              keyboardType: TextInputType.emailAddress,
              controller: handleChange.add('email'),
              decoration: new InputDecoration(
                  labelText: 'E-mail', icon: Icon(Icons.email)),
              onChanged: (v) => user.email = v,
            ),
            new TextField(
              keyboardType: TextInputType.datetime,
              enabled: handleChange.addDisabled('birthdate'),
              controller: handleChange.add('birthdate'),
              decoration: InputDecoration(
                  labelText: 'Data de nascimento',
                  icon: Icon(Icons.date_range)),
              onChanged: (v) => user.birthdate = v,
            ),
            Divider(
              indent: 10,
            ),
            new TextField(
              keyboardType: TextInputType.text,
              enabled: handleChange.addDisabled('userLogin'),
              controller: handleChange.add('userLogin'),
              decoration: new InputDecoration(
                  labelText: 'Login', icon: Icon(Icons.person_pin)),
              onChanged: (v) => user.userLogin = v,
            ),
            new TextField(
              controller: handleChange.add('password'),
              enabled: handleChange.addDisabled('password'),
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  labelText: 'Senha', icon: Icon(Icons.enhanced_encryption)),
              onChanged: (v) => user.password = v,
              obscureText: true,
            ),
            new ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserList()));
                  },
                  child: new Text('Voltar'),
                ),
                new RaisedButton(
                  child: new Text(
                    'Inserir',
                    style: new TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    submit();
                  },
                  color: Colors.blue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;

      if (_image == null) {
        return;
      } else {
        this.user.profileImage = _image.absolute.path;
      }
    });
  }

  void submit() async {
    if (this.userId == null)
      await UserService().insert('api/user/insert', this.user.toMap());
    else
      await UserService().edit('api/user/edit', this.user.toMap());

    Navigator.pop(context, true);
  }
}
