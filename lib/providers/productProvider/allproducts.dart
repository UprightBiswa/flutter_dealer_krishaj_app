import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:krishajdealer/services/api/peoducts_api_responce_model.dart';

class AllProductViewProvider extends ChangeNotifier {
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

  Future<ApiResponseModelProducts> getProducts(BuildContext context) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);

        return ApiResponseModelProducts(
          success: false,
          message: 'No internet connection',
          products: [],
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/products',
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print('Successful Response: ${response.data}');
        return ApiResponseModelProducts.fromJson(response.data);
      } else {
        _showToast(context, 'Error: ${response.statusCode}', isError: true);
        print('Error Response: ${response.data}');

        return ApiResponseModelProducts(
          success: false,
          message: 'Error: ${response.statusCode}',
          products: [],
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      print('Exception: $e');

      return ApiResponseModelProducts(
        success: false,
        message: 'Error occurred: $e',
        products: [],
      );
    }
  }

  Future<ApiResponseModelProductDetails> getProductDetails({
    required BuildContext context,
    required int productId,
    required int materialId,
  }) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);

        return ApiResponseModelProductDetails(
          success: false,
          message: 'No internet connection',
          productDetails: null,
          materialInfo: null,
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/product_details',
        data: {
          'product_id': productId,
          'material_id': materialId, // Pass materialId in the request
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print('Successful Response: ${response.data}');
        // Print material info data
        if (response.data['material_info'] != null) {
          print('Material Info Data: ${response.data['material_info']}');
        } else {
          print('Material Info Data is null');
        }
        return ApiResponseModelProductDetails.fromJson(response.data);
      } else {
        _showToast(context, 'Error: ${response.statusCode}', isError: true);
        print('Error Response: ${response.data}');

        return ApiResponseModelProductDetails(
          success: false,
          message: 'Error: ${response.statusCode}',
          productDetails: null,
          materialInfo: null,
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      print('Exception: $e');

      return ApiResponseModelProductDetails(
        success: false,
        message: 'Error occurred: $e',
        productDetails: null,
        materialInfo: null,
      );
    }
  }
}
