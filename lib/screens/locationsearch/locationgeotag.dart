import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationGeotagWidget extends StatelessWidget {
  const LocationGeotagWidget({Key? key}) : super(key: key);

  Future<String?> _getSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fullAddress = prefs.getString('selectedFullAddress');
    return fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getSavedAddress(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(
              'Location: ${snapshot.data}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          } else {
            return Text('Location not set');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
