import 'package:barber_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderInfo with ChangeNotifier {
  List<Order> orders = [];

  void addNewOrder(Order newOrder) {
    orders.add(newOrder);
    notifyListeners();
  }

  void removeOrder(int service_id) {
    orders.removeWhere((order) => order.service_id == service_id);
    notifyListeners();
  }

  void clearAllOrder() {
    orders = [];
    notifyListeners();
  }
}
