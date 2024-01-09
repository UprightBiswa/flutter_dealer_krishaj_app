import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState with ChangeNotifier {
  String _token = '';
  String _customerName = ''; // Added customerName
  String _regionCode = ''; // Added regionCode
  String _customerNumber = ''; // Added customerNumber

  String get token => _token;
  String get customerName => _customerName; // Added getter for customerName
  String get regionCode => _regionCode; // Added getter for regionCode
  String get customerNumber => _customerNumber;
  Future<void> setToken(
      String newToken, String newCustomerName, String newRegionCode, String newCustomerNumber) async {
    _token = newToken;
    _customerName = newCustomerName;
    _regionCode = newRegionCode;
    _customerNumber = newCustomerNumber;

    // Save token to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
    await prefs.setString('customerName', _customerName);
    await prefs.setString('regionCode', _regionCode);
    await prefs.setString('customerNumber', _customerNumber);

    // Log the saved values
    print('Token saved: $_token');
    print('Customer Name saved: $_customerName');
    print('Region Code saved: $_regionCode');
     print('customerNumber Code saved: $_customerNumber');
    notifyListeners();
  }

  Future<String?> getToken() async {
    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getCustomerName() async {
    // Retrieve customerName from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customerName');
  }

  Future<String?> getRegionCode() async {
    // Retrieve regionCode from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('regionCode');
  }

  Future<String?> getCustomerNumnber() async {
    // Retrieve regionCode from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('customerNumber');
  }
}
