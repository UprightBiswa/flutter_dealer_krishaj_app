import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int _cartCount = 0;

  int get cartCount => _cartCount;

  Future<void> updateCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartCount = prefs.getInt('cartCount') ?? 0;
    notifyListeners();
  }

  Future<void> addToCart(int cartCountvalue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cartCount = cartCountvalue;
    prefs.setInt('cartCount', _cartCount);
    notifyListeners();
  }
}
