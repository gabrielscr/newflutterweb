class User {
  int id;
  String name;
  String birthDate;
  String email;
  String password;
  String userName;
  String image;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthDate = json['birthDate'],
        id = json['id'],
        password = json['password'],
        userName = json['userName'],
        image = json['image'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'id': id,
        'userName': userName,
        'password': password,
        'image': image
      };
}
