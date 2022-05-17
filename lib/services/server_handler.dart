import 'dart:convert';

import 'package:barber_app/models/basicUser.dart';
import 'package:barber_app/models/shop.dart';
import 'package:barber_app/models/shop_hours.dart';
import 'package:barber_app/models/worker_hour.dart';
import 'package:http/http.dart' as http;

import '../models/service.dart';
import '../models/worker.dart';

class ServerHandler {
  /// For emulator
  final String _baseUrl = 'http://10.0.2.2/find_best_API/api';

  /// For Flutter Web
  // final String _baseUrl = 'http://localhost/find_best_API/api';

  /// SHOP TABLE
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
          'user_id': shop.user_id.toString(),
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

  Future<Map<dynamic, dynamic>?> fetchOneShop(int user_id) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/shop/fetch_one_shop.php'),
        body: {
          'user_id': user_id.toString(),
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

  /// USER TABLE
  Future<Map<dynamic, dynamic>?> registerUser(BasicUser basicUser) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/user/register.php'),
        body: {
          'name': basicUser.name,
          'surname': basicUser.surname,
          'email': basicUser.email,
          'password': basicUser.password,
          'gender': basicUser.gender,
          'birthday': basicUser.birthday,
          'phone_no': basicUser.phoneNumber,
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

  Future<Map<dynamic, dynamic>?> fetchOneUser(String email) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/user/fetch_one_user.php'),
        body: {
          'email': email,
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

  Future<Map<dynamic, dynamic>?> updateUserForShopId(
      int shop_id, int user_id) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/user/update_user_shop_id.php'),
        body: {
          'user_id': user_id.toString(),
          'shop_id': shop_id.toString(),
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

  /// WORKER TABLE
  Future<Map<dynamic, dynamic>?> addNewWorker(
      {required Worker worker, required int shop_id}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/worker/add_worker.php'),
        body: {
          'shop_id': shop_id.toString(),
          'worker_name': worker.name,
          'fav_num': "1",
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

  Future<Map<dynamic, dynamic>?> fetchOneWorker(
      int shop_id, String worker_name) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/worker/fetch_one_worker.php'),
        body: {
          'shop_id': shop_id.toString(),
          'worker_name': worker_name,
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

  /// WORKER HOUR TABLE
  Future<Map<dynamic, dynamic>?> addNewWorkerHour(
      {required WorkerHour workerHour, required String worker_id}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/worker_hour/add_worker_hour.php'),
        body: {
          'worker_id': worker_id,
          'day': workerHour.day,
          'start_hour': workerHour.startTime,
          'finish_hour': workerHour.finishTime,
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

  /// SHOP HOUR TABLE
  Future<Map<dynamic, dynamic>?> addNewShopHour(
      {required ShopHours shopHour, required String shop_id}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/shop_hour/add_shop_hour.php'),
        body: {
          'shop_id': shop_id,
          'day': shopHour.day,
          'start_hour': shopHour.startTime,
          'finish_hour': shopHour.endTime,
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

  /// SERVICE TABLE
  Future<Map<dynamic, dynamic>?> addNewService(
      {required Service service, required String shop_id}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$_baseUrl/shop_hour/add_shop_hour.php'),
        body: {
          'shop_id': shop_id,
          'service_name': service.serviceName,
          'price': service.price,
          'hour_process': service.hourOfProcess,
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