import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({Key? key}) : super(key: key);

  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA9jSDwr00hpL_pxHJ48gYfXWLT8-kxlJA');
  List<PlacesSearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _checkLocationPermission();
    await _checkInternetConnection();
    await _getCurrentLocation();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showSnackbar('No internet connection');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      _showSnackbar('Please enable location services on your device');
      return;
    }

    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
        
        if (_currentLocation != null) {
          _animateToUserLocation();
        }
      } catch (e) {
        print('Error getting location: $e');
        _showSnackbar('Error getting location. Please try again.');
      }
    } else {
      _showSnackbar('Location permission not granted');
    }
  }

  void _animateToUserLocation() async {
    try {
      if (_currentLocation != null) {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            _currentLocation!,
            14.0,
          ),
        );
      }
    } catch (e) {
      print('Error animating to user location: $e');
    }
  }

  Future<void> _searchPlaces(String query) async {
    PlacesSearchResponse response = await places.searchByText(
      query,
      language: 'en',
    );

    if (response.isOkay && response.results.isNotEmpty) {
      setState(() {
        _searchResults = response.results;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _saveLocationPreference(LatLng location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('selectedLatitude', location.latitude);
    prefs.setDouble('selectedLongitude', location.longitude);
    print('save location preference');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Search'),
      ),
      body: Column(
        children: [
          Container(
            height: 200, // Set the height of the map view
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? LatLng(0, 0),
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              markers: _currentLocation != null
                  ? Set<Marker>.from([
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: _currentLocation!,
                        infoWindow: InfoWindow(
                          title: 'Your Location',
                        ),
                      ),
                    ])
                  : Set<Marker>(),
              onTap: (LatLng position) {
                setState(() {
                  _currentLocation = position;
                });
                _saveLocationPreference(_currentLocation!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16.0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search for a location',
              ),
              onChanged: (query) {
                // Perform search logic here
                // Update the list of search results
                _searchPlaces(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  title: Text(result.name ?? ''),
                  subtitle: Text(result.formattedAddress ?? ''),
                  onTap: () async {
                    final lat = result.geometry!.location.lat;
                    final lng = result.geometry!.location.lng;

                    setState(() {
                      _currentLocation = LatLng(lat, lng);
                    });

                    _mapController!.animateCamera(
                        CameraUpdate.newLatLng(LatLng(lat, lng)));

                    await _saveLocationPreference(_currentLocation!);

                    // Navigator.pop(
                    //     context); // Navigate back or close the search page
                  },
                );
              },
            ),
          ),
          if (_currentLocation != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
