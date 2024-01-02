import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  String _token = '';

  String get token => _token;

  Future<void> setToken(String newToken) async {
    _token = newToken;

    // Save token to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
    // Log the saved token
    print('Token saved: $_token');
    notifyListeners();
  }

  Future<String?> getToken() async {
    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Other methods and properties...
}
