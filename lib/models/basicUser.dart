class BasicUser {
  int? userId;
  String? type;
  String email;
  String password;
  String name;
  String surname;
  String city;
  String gender;
  String birthday;
  String phoneNumber;
  int? shopId;

  BasicUser({
    this.userId,
    this.type,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.city,
    required this.gender,
    required this.birthday,
    required this.phoneNumber,
    this.shopId,
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

  factory BasicUser.fromMapForRegister(Map map) {
    return BasicUser(
      email: map['email'],
      password: map['password'],
      name: map['name'],
      surname: map['surname'],
      city: map['city'],
      gender: map['gender'],
      birthday: map['birthday'],
      phoneNumber: map['phone_no'],
    );
  }

  factory BasicUser.fromMapForLogin(Map map) {
    print('map in the basicUser model class: $map');
    print('type of shop_id: ${map['shop_id'].runtimeType}');
    return BasicUser(
      userId: int.parse(map['user_id']),
      email: map['email'],
      password: '',
      name: map['name'],
      surname: map['surname'],
      city: map['city'],
      gender: map['gender'],
      birthday: map['birthday'],
      phoneNumber: map['phone_no'],
      shopId: map['shop_id'] == null ? null : int.parse(map['shop_id']),
    );
  }
}
