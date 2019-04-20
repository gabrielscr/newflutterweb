class User {
  int id;
  String name;
  String birthdate;
  String email;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthdate = json['birthdate'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthdate': birthdate,
        'id': id,
      };
}
