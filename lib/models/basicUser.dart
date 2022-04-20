class BasicUser {
  String type;
  String email;
  String password;
  String name;
  String surname;
  String city;
  String gender;
  String birthday;
  String phoneNumber;

  BasicUser({
    required this.type,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.city,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() => {
        'type': type,
        'email': email,
        'password': password,
        'name': name,
        'surname': surname,
        'city': city,
        'gender': gender,
        'birthday': birthday,
        'phoneNumber': phoneNumber,
      };

  factory BasicUser.fromMap(Map map) {
    return BasicUser(
      type: map['type'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      surname: map['surname'],
      city: map['city'],
      gender: map['gender'],
      birthday: map['birthday'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
