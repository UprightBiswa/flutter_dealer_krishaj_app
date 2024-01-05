import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:krishajdealer/services/api/announcement_model.dart';

class AnnouncementProvider extends ChangeNotifier {
  final Dio _dio = Dio();

  Future<bool> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<AnnouncementModel> getAnnouncements(BuildContext context) async {
    try {
      if (await _checkInternet()) {
        final response = await _dio.post(
          'https://krepl.indigidigital.in/api/announcements',
        );

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          print('Successful Response: ${response.data}');

          // Show success toast
          _showToast(context, 'Announcements loaded successfully', false);

          return AnnouncementModel.fromJson(response.data);
        } else {
          print('Error Response: ${response.data}');

          // Show error toast
          _showToast(context, 'Error: ${response.statusCode}', true);

          throw Exception('Error: ${response.statusCode}');
        }
      } else {
        // Show no internet connection toast
        _showToast(context, 'No internet connection', true);

        throw Exception('No internet connection');
      }
    } catch (e) {
      print('Exception: $e');

      // Show generic error toast
      _showToast(context, 'Error occurred: $e', true);

      throw Exception('Error occurred: $e');
    }
  }

  void _showToast(BuildContext context, String message, bool isError) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
    )..show(context);
  }
}
