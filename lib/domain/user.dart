class User {
  int id;
  String name;
  String birthdate;
  String email;

  User(int id, String name, String email, String birthdate) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.birthdate = birthdate;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        birthdate = json['birthdate'],
        email = json['email'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'birthdate': birthdate};
  }
}