class User {
  int id;
  String name;
  String birthdate;
  String email;
  String password;
  String userName;
  String image;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthdate = json['birthdate'],
        id = json['id'],
        password = json['password'],
        userName = json['userName'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthdate': birthdate,
        'id': id,
        'userName': userName,
        'password': password,
        'image': image
      };
}
