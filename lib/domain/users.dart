import 'package:newflutterproject/domain/user.dart';

class Users {
  final List<User> users;
  final int totalUsers;
  final int pageNumber;
  final int pageSize;

  Users({this.users, this.totalUsers, this.pageNumber, this.pageSize});

  Users.fromMap(Map<String, dynamic> map)
      : users = new List<User>.from(map['users'].map((product) => new User.fromJson(product))),
        totalUsers = map['totalUsers'],
        pageNumber = map['pageNumber'],
        pageSize = map['pageSize'];
}