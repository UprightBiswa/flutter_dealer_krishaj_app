// cart_increment_decrement_provider.dart

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:krishajdealer/services/api/cartincrementdecrementmodel.dart';

class CartIncrementDecrementProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<bool> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showToast(BuildContext context, String message,
      {bool isError = false}) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
    )..show(context); // Pass the context to the show method.
  }

  Future<CartIncrementDecrementModel> cartIncrement({
    required BuildContext context,
    required String token,
    required int quantity,
    required int cartId,
  }) async {
    try {
      if (await _checkInternet()) {
        final response = await _dio.post(
          'https://krepl.indigidigital.in/api/cartincrement',
          queryParameters: {
            'token': token,
            'quantity': quantity,
            'cart_id': cartId,
          },
        );

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          print('Successful Response: ${response.data}');
          return CartIncrementDecrementModel.fromJson(response.data);
        } else {
          _showToast(context, 'Error: ${response.statusCode}', isError: true);
          print('Error Response: ${response.data}');

          return CartIncrementDecrementModel(
            success: false,
            message: 'Error: ${response.statusCode}',
           
          );
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      print('Exception: $e');

      return CartIncrementDecrementModel(
        success: false,
        message: 'Error occurred: $e',
       
      );
    }
  }

  Future<CartIncrementDecrementModel> cartDecrement({
    required BuildContext context,
    required String token,
    required int quantity,
    required int cartId,
  }) async {
    try {
      if (await _checkInternet()) {
        final response = await _dio.post(
          'https://krepl.indigidigital.in/api/cartdecrement',
          queryParameters: {
            'token': token,
            'quantity': quantity,
            'cart_id': cartId,
          },
        );

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          print('Successful Response: ${response.data}');
          return CartIncrementDecrementModel.fromJson(response.data);
        } else {
          _showToast(context, 'Error: ${response.statusCode}', isError: true);
          print('Error Response: ${response.data}');

          return CartIncrementDecrementModel(
            success: false,
            message: 'Error: ${response.statusCode}',
           
          );
        }
      } else {
        throw Exception('No internet connection');
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      print('Exception: $e');

      return CartIncrementDecrementModel(
        success: false,
        message: 'Error occurred: $e',
       
      );
    }
  }

  // Add similar error handling for other methods if needed
}
