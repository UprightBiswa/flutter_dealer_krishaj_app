import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:krishajdealer/services/api/card_api_responce_model.dart';

class CartProductViewProvider extends ChangeNotifier {
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

  Future<ApiResponseModelCartItem> viewCartDetails(
    String token,
    BuildContext context,
  ) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);

        return ApiResponseModelCartItem(
          success: false,
          message: 'No internet connection',
          totalProducts: 0,
          cartItems: [],
          totalPricesSum: '',
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/view_cart_details',
        data: {'token': token},
      );
      // Log the response data
      print('Response Data: ${response.data}');
      // Check for a successful response status (2xx)
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Log successful response
        print('Successful Response: ${response.data}');
        return ApiResponseModelCartItem.fromJson(response.data);
      } else if (response.statusCode == 500) {
        // Handle 500 errors in a specific way
        _showToast(context, 'Server error. Please try again later.',
            isError: true);
        return ApiResponseModelCartItem(
          success: false,
          message: 'Server error. Please try again later.',
          totalProducts: 0,
          cartItems: [],
          totalPricesSum: '',
        );
      } else {
        // Handle unexpected status codes
        _showToast(context, 'Unexpected status code: ${response.statusCode}',
            isError: true);
        // Log error response
        print('Error Response: ${response.data}');

        return ApiResponseModelCartItem(
          success: false,
          message: 'Unexpected status code: ${response.statusCode}',
          totalProducts: 0,
          cartItems: [],
          totalPricesSum: '',
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      // Log exception
      print('Exception: $e');

      return ApiResponseModelCartItem(
        success: false,
        message: 'Error occurred: $e',
        totalProducts: 0,
        cartItems: [],
        totalPricesSum: '',
      );
    }
  }
}
