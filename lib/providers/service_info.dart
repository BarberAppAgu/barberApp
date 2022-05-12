import 'package:barber_app/models/service.dart';
import 'package:flutter/material.dart';

class ServiceInfo with ChangeNotifier {
  List<Service> allService = [];

  void updateServiceList(List<dynamic> newServicesList) {
    print(newServicesList);
    allService = newServicesList.map((e) => e as Service).toList();
    notifyListeners();
  }
}
