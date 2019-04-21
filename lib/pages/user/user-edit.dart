import 'package:flutter/material.dart';
import 'package:newflutterproject/domain/user.dart';
import 'package:newflutterproject/pages/user/user-service.dart';

class UserEdit extends StatefulWidget {
  final int userId;

  UserEdit({this.userId});

  @override
  _UserInsertEdit createState() => _UserInsertEdit(userId: this.userId);
}

class _UserInsertEdit extends State<UserEdit> {
  final int userId;

  var user = User();
  // ToDo: do a better code to make generic to control all the input fields
  var txtName = new TextEditingController();
  var txtEmail = new TextEditingController();
  var txtBirthDate = new TextEditingController();
  var txtSalary = new TextEditingController();

  _UserInsertEdit({this.userId});

  getUser() async {
    var userFromServer = new User();

    if (userId != null) {
      var response =
          await UserService().get('/api/person/get', {'id': this.userId});
          
      userFromServer = User.fromJson(response);
      txtName.text = userFromServer.name;
      txtEmail.text = userFromServer.email;
      txtBirthDate.text = userFromServer.birthdate;

    }

    setState(() {
      user = userFromServer;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var appBarText = this.userId == null ? 'Insert User' : 'Edit User';

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Form(
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            new TextField(
              controller: txtName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Type your full name',
                  labelText: 'Name',
                  icon: Icon(Icons.person)),
              onChanged: (e) => user.name = e,
            ),
            new TextField(
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter a valid email',
                  labelText: 'Email',
                  icon: Icon(Icons.email)),
              onChanged: (e) => user.email = e,
            ),
            new TextField(
              controller: txtBirthDate,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  hintText: 'Enter your birth date',
                  labelText: 'Birth date',
                  icon: Icon(Icons.date_range)),
              onChanged: (e) => user.birthdate = e,
            ),
            new TextField(
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  labelText: 'Salário',
                  prefixText: 'R\$',
                  suffixText: 'Reais',
                  suffixStyle: TextStyle(color: Colors.green),
                  icon: Icon(Icons.attach_money)),
              onChanged: (e) => user.email = e,
            ),
          ],
        ),
      ),
    );
  }
}
