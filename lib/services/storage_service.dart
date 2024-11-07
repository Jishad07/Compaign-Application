// lib/services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static Future<void> saveUserData(String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_data', json.encode({'name': name, 'email': email}));
  }

  static Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');
    if (userData != null) {
      Map<String, dynamic> data = json.decode(userData);
      return {
        'name': data['name'],
        'email': data['email'],
      };
    }
    return {'name': '', 'email': ''};
  }
}
