import 'dart:io';

import 'package:barber_app/models/shop.dart';
import 'package:flutter/material.dart';

class ShopInfo with ChangeNotifier {
  Shop shop = Shop(
    typeOfShop: 'Type Of Shop',
    name: '',
    address: '',
    lat: 0,
    lng: 0,
    favNum: 0,
    imgUrl: 'imgUrl',
    user_id: 0,
  );
  File? imageFile;

  void updateLatLng(double lat, double lng) {
    shop.lat = lat;
    shop.lng = lng;
    notifyListeners();
  }

  void updateShopInformation(String typeOfShop, String name, String address) {
    shop.typeOfShop = typeOfShop;
    shop.name = name;
    shop.address = address;
    notifyListeners();
  }

  void updateShopImage(File? newImageFile) {
    imageFile = newImageFile;
    notifyListeners();
  }

  void updateShopUserId(int currentShopId) {
    shop.user_id = currentShopId;
    notifyListeners();
  }
}