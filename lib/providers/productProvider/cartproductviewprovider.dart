import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:krishajdealer/services/api/card_api_responce_model.dart';
import 'package:krishajdealer/services/api/orderplacementresponce.dart';

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
      print('Exceptiofgfhfhn: $e');

      return ApiResponseModelCartItem(
        success: false,
        message: 'Error occurred: $e',
        totalProducts: 0,
        cartItems: [],
        totalPricesSum: '',
      );
    }
  }

  Future<RemoveCartItemResponse> removeCartItem(
      BuildContext context, String token, int cartId) async {
    if (await _checkInternet()) {
      try {
        final response = await _dio.post(
          'https://krepl.indigidigital.in/api/remove_cart_details',
          data: {
            'token': token,
            'cart_id': cartId.toString(),
          },
        );

        if (response.statusCode == 200) {
          final data = response.data;
          return RemoveCartItemResponse.fromJson(data);
        } else {
          print('Error Response: ${response.data}');
          // Handle error response
          _showToast(context, 'Failed to remove cart item', isError: true);
          return RemoveCartItemResponse(
            success: false,
            data: 'Failed to remove cart item',
            totalProducts: 0,
            totalProductsSum: '0',
          );
        }
      } catch (error) {
        // Handle network or other errors
        _showToast(context, 'Error: $error', isError: true);
        return RemoveCartItemResponse(
          success: false,
          data: 'Error: $error',
          totalProducts: 0,
          totalProductsSum: '0',
        );
      }
    } else {
      _showToast(context, 'No internet connection', isError: true);
      return RemoveCartItemResponse(
        success: false,
        data: 'No internet connection',
        totalProducts: 0,
        totalProductsSum: '0',
      );
    }
  }

  Future<OrderPlacementResponse> placeOrder(
      BuildContext context, String token, double total) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        print('no internet connection');
        _showToast(context, 'No internet connection', isError: true);

        return OrderPlacementResponse(
          success: false,
          message: 'No internet connection',
          orderId: null,
          cartCount: 0,
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/place_order',
        data: {'token': token, 'total': total},
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print('Successful Order Placement Response: ${response.data}');
        // return OrderPlacementResponse.fromJson(response.data);
        // Assuming the API response is stored in a variable named 'response'
        OrderPlacementResponse orderPlacementResponse =
            OrderPlacementResponse.fromJson(response.data);

        // Use the orderPlacementResponse as needed
        print('Order ID: ${orderPlacementResponse.orderId}');
        print('Cart Count: ${orderPlacementResponse.cartCount}');

        return orderPlacementResponse;
      } else if (response.statusCode == 500) {
        _showToast(
          context,
          'Server error. Please try again later.',
          isError: true,
        );
        return OrderPlacementResponse(
          success: false,
          message: 'Server error. Please try again later.',
          orderId: null,
          cartCount: 0,
        );
      } else {
        _showToast(
          context,
          'Unexpected status code: ${response.statusCode}',
          isError: true,
        );
        return OrderPlacementResponse(
          success: false,
          message: 'Unexpected status code: ${response.statusCode}',
          orderId: null,
          cartCount: 0,
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      return OrderPlacementResponse(
        success: false,
        message: 'Error occurred: $e',
        orderId: null,
        cartCount: 0,
      );
    }
  }
}
