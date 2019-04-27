class User {
  int id;
  String name;
  String lastName;
  String birthdate;
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
        birthdate = json['birthdate'],
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
        'birthdate': birthdate,
        'id': id,
        'userLogin': userLogin,
        'password': password,
        'profileImage': profileImage,
        'active': active,
        'gender' : gender
      };
}
