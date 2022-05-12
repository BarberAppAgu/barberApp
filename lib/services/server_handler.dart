import 'dart:convert';

import 'package:barber_app/models/shop.dart';
import 'package:http/http.dart' as http;

class ServerHandler {
  /// For emulator
  final String _baseUrl = 'http://10.0.2.2/find_best_API/api';

  /// For Flutter Web
  // final String _baseUrl = 'http://localhost/find_best_API/api';

  // For register user
  Future<Map<dynamic, dynamic>?> addNewShop({required Shop shop}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/shop/add_shop.php'),
        body: {
          'type_shop': shop.typeOfShop,
          'name': shop.name,
          'address': shop.address,
          'lat': shop.lat.toString(),
          'lng': shop.lng.toString(),
          'fav_num': "1",
          'img_url': shop.imgUrl,
        },
      );

      Map<dynamic, dynamic> result = jsonDecode(response.body);
      print('result: $result');
      return result;
    } catch (e) {
      print('Server Handler: Error : $e');
    }
    return null;
  }
}
