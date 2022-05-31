import 'package:barber_app/models/basicUser.dart';
import 'package:flutter/material.dart';

class BasicUserInfo with ChangeNotifier {
  BasicUser basicUser = BasicUser(
    type: 'User',
    email: '',
    password: '',
    name: '',
    surname: '',
    city: 'Select City',
    gender: 'Select Gender',
    birthday: '',
    phoneNumber: '',
  );

  void updateType(String newType) {
    basicUser.type = newType;
    notifyListeners();
  }

  void updateEmailAndPassword(String email, String password) {
    basicUser.email = email;
    basicUser.password = password;
    notifyListeners();
  }

  void updateGeneralUserInfo(String name, String surname, String city,
      String gender, String birthday, String phoneNumber) {
    basicUser.name = name;
    basicUser.surname = surname;
    basicUser.city = city;
    basicUser.gender = gender;
    basicUser.birthday = birthday;
    basicUser.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateAllUserInfo(BasicUser newBasicUser) {
    basicUser = newBasicUser;
    notifyListeners();
  }

  void clearUserInfo() {
    basicUser = BasicUser(
      type: 'User',
      email: '',
      password: '',
      name: '',
      surname: '',
      city: 'Select City',
      gender: 'Select Gender',
      birthday: '',
      phoneNumber: '',
    );
    notifyListeners();
  }
}
