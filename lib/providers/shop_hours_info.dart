import 'package:barber_app/models/shop_hours.dart';
import 'package:flutter/material.dart';

class ShopHoursInfo with ChangeNotifier {
  List<ShopHours> shopHoursList = [];

  void updateShopHourList(List<ShopHours> newList) {
    shopHoursList.clear();
    shopHoursList = newList;
    notifyListeners();
  }
}
