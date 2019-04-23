class User {
  int id;
  String name;
  String lastName;
  String age;
  String email;
  String password;
  String userLogin;
  String profileImage;
  String gender;
  bool active;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lastName = json['lastName'],
        email = json['email'],
        age = json['age'],
        id = json['id'],
        password = json['password'],
        userLogin = json['userLogin'],
        gender = json['gender'],
        profileImage = json['profileImage'],
        active = json['active'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'lastName': lastName,
        'email': email,
        'age': age,
        'id': id,
        'userLogin': userLogin,
        'password': password,
        'profileImage': profileImage,
        'active': active,
        'gender' : gender
      };
}
