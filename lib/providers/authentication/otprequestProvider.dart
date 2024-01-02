// import 'package:dio/dio.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:krishajdealer/services/api/loginotp/request_otp_responce_model.dart';

// class OtpRequestProvider {
//   final Dio _dio = Dio();

//   Future<OtpRequestResponse> requestOtp({required String username}) async {
//     try {
//       bool isConnected = await _checkInternet();

//       if (!isConnected) {
//         return OtpRequestResponse(
//           success: false,
//           message: 'No internet connection',
//         );
//       }

//       Response response = await _dio.get(
//         'https://krepl.indigidigital.in/api/request_otp',
//         queryParameters: {'username': username},
//       );

//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return OtpRequestResponse.fromJson(response.data);
//       } else {
//         return OtpRequestResponse(
//           success: false,
//           message: 'Unexpected status code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return OtpRequestResponse(
//         success: false,
//         message: 'Error occurred: $e',
//       );
//     }
//   }

//   Future<bool> _checkInternet() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
// }
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:krishajdealer/services/api/loginotp/request_otp_responce_model.dart';
import 'package:krishajdealer/services/api/loginotp/verify_otp_responce.dart';

class RequestOtpProvider extends ChangeNotifier {
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

  Future<OtpRequestResponse> requestOtp({
    required BuildContext context,
    required String username,
  }) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);
        return OtpRequestResponse(
          success: false,
          message: 'No internet connection',
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/request_otp',
        queryParameters: {'username': username},
      );

      // Check for a successful response status (2xx)
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Log the OTP request response
        print('OTP Request Response: ${response.data}');
        return OtpRequestResponse(
          success: response.data['success'],
          message: response.data['message'],
        );
      } else {
        // Handle unexpected status codes
        _showToast(context, 'Unexpected status code: ${response.statusCode}',
            isError: true);
        return OtpRequestResponse(
          success: false,
          message: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      return OtpRequestResponse(
        success: false,
        message: 'Error occurred: $e',
      );
    }
  }

  Future<VerifyOtpResponse> verifyOtp({
    required BuildContext context,
    required String username,
    required String otp,
  }) async {
    try {
      bool isConnected = await _checkInternet();

      if (!isConnected) {
        _showToast(context, 'No internet connection', isError: true);
        return VerifyOtpResponse(
          success: false,
          message: 'No internet connection',
        );
      }

      Response response = await _dio.post(
        'https://krepl.indigidigital.in/api/verify_otp',
        queryParameters: {'otp': otp, 'phone_no': username},
      );

      // Check for a successful response status (2xx)
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        // Log the verification response
        print('Verification Response: ${response.data}');
        return VerifyOtpResponse(
          success: response.data['success'],
          message: response.data['message'],
          data: VerifyOtpData.fromJson(response.data['data']),
        );
      } else {
        // Handle unexpected status codes
        _showToast(context, 'Unexpected status code: ${response.statusCode}',
            isError: true);
        return VerifyOtpResponse(
          success: false,
          message: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _showToast(context, 'Error occurred: $e', isError: true);
      return VerifyOtpResponse(
        success: false,
        message: 'Error occurred: $e',
      );
    }
  }
}
