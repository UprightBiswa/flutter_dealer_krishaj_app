// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:krishajdealer/services/api/api_responce_moodel.dart';

// class ProductProvider extends ChangeNotifier {
//   final Dio _dio = Dio();

//   Future<ApiResponseModel> addToCart({
//     required int productId,
//     required int quantity,
//     required double price,
//     required String token,
//     required String company,
//   }) async {
//     try {
//       Response response = await _dio.post(
//         'https://krepl.indigidigital.in/api/add_to_cart',
//         data: {
//           'product_id': productId,
//           'quantity': quantity,
//           'price': price,
//           'token': token,
//           'company': company,
//         },
//       );

//       return ApiResponseModel(
//         success: response.data['success'],
//         message: response.data['message'],
//         totalProducts: response.data['total_products'],
//       );
//     } catch (e) {
//       // Handle DioError, network error, or other exceptions
//       return ApiResponseModel(
//         success: false,
//         message: 'Error occurred: $e',
//         totalProducts: 0,
//       );
//     }
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:krishajdealer/services/api/api_responce_moodel.dart';

class ProductProvider extends ChangeNotifier {
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

  Future<ApiResponseModel> addToCart({
    required BuildContext context,
    required String productNumber,
    required int quantity,
    required double price,
    required String token,
    required String company,
  }) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);
        return ApiResponseModel(
          success: false,
          message: 'No internet connection',
          totalProducts: 0,
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/add_to_cart',
        data: {
          'product_number': productNumber,
          'quantity': quantity,
          'price': price,
          'token': token,
          'company': company.toUpperCase(),
          
        },
      );

      // Check for a successful response status (2xx)
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ApiResponseModel(
          success: response.data['success'],
          message: response.data['message'],
          totalProducts: response.data['total_products'],
        );
      } else {
        // Handle unexpected status codes
        _showToast(context, 'Unexpected status code: ${response.statusCode}',
            isError: true);
        return ApiResponseModel(
          success: false,
          message: 'Unexpected status code: ${response.statusCode}',
          totalProducts: 0,
        );
      }
    } catch (e) {
        print('Error occurred: $e'); // Log the error
      _showToast(context, 'Error occurred: $e', isError: true);
      return ApiResponseModel(
        success: false,
        message: 'Error occurred: $e',
        totalProducts: 0,
      );
    }
  }
}
