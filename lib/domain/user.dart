class User {
  int id;
  String name;
  String birthdate;
  String email;
  String salary;
  bool isMarried = false;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        birthdate = json['birthdate'],
        id = json['id'],
        salary = json['salary'],
        isMarried = json['isMarried'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthdate': birthdate,
        'id': id,
        'salary': salary,
        'isMarried': isMarried
      };
}
