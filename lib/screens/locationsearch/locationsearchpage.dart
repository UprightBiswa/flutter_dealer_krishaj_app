import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishajdealer/utils/colors.dart';
import 'package:krishajdealer/widgets/common/custom_button.dart';
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
  String? fullAddress;
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

        // Check if the widget is still mounted before updating the state
        if (mounted) {
          setState(() {
            _currentLocation = LatLng(position.latitude, position.longitude);
          });
        }

        try {
          // Reverse geocode the selected coordinates
          final addresses = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          if (addresses.isNotEmpty) {
            final place = addresses.first;
            // Check if the widget is still mounted before updating the state
            if (mounted) {
              setState(() {
                fullAddress =
                    "${place.name}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}";
              });
            }
          } else {
            _showAddressNotFoundSnackbar();
          }
        } catch (error) {
          print("Geocoding error: $error");
          _showGeocodingErrorSnackbar();
        }
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
    try {
      await _checkLocationPermission();
      await _checkInternetConnection();

      PlacesSearchResponse response = await places.searchByText(
        query,
        language: 'en',
      );

      if (response.isOkay && response.results.isNotEmpty) {
        setState(() {
          _searchResults = response.results;
        });
      } else {
        _showSnackbar('No places found matching your query');
      }
    } on SocketException catch (e) {
      _showSnackbar('Failed to connect to the server');
    } catch (e) {
      _showSnackbar('An error occurred');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showAddressNotFoundSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address not found'),
      ),
    );
  }

  void _showGeocodingErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error fetching address'),
      ),
    );
  }

  Future<void> _saveLocationPreference(
      LatLng location, String fullAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('selectedLatitude', location.latitude);
    prefs.setDouble('selectedLongitude', location.longitude);
    prefs.setString('selectedFullAddress', fullAddress);
    print('save location preference');
    print('Saved full address preference: $fullAddress');
  }

  @override
  void dispose() {
    // Dispose of resources when the page closes
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBackground,
      appBar: AppBar(
         backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.lightGreen.withOpacity(0.5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text('Location Search'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16.0),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Colors.grey), // Add gray border here
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
              if (_currentLocation != null && fullAddress != null)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Selected Location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}, ${fullAddress!}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 200, // Set the height of the map view
                color: Colors.white,
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
                  onTap: (LatLng position) async {
                    setState(() {
                      _currentLocation = position;
                    });
                    try {
                      // Reverse geocode the selected coordinates
                      final addresses = await placemarkFromCoordinates(
                          position.latitude, position.longitude);
                      if (addresses.isNotEmpty) {
                        final place = addresses.first;
                        setState(() {
                          _currentLocation = position;
                          fullAddress =
                              "${place.name}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}";
                        });
                      } else {
                        _showAddressNotFoundSnackbar();
                      }
                    } catch (error) {
                      print("Geocoding error: $error");
                      _showGeocodingErrorSnackbar();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(result.name ?? ''),
                          subtitle: Text(result.formattedAddress ?? ''),
                          onTap: () async {
                            final lat = result.geometry!.location.lat;
                            final lng = result.geometry!.location.lng;
                            final fullAddressToset =
                                '${result.name}, ${result.formattedAddress!}';
                            setState(() {
                              _currentLocation = LatLng(lat, lng);
                              fullAddress = fullAddressToset;
                            });

                            _mapController!.animateCamera(
                                CameraUpdate.newLatLng(LatLng(lat, lng)));

                            // await _saveLocationPreference(
                            //     _currentLocation!, fullAddress!);

                            // Navigator.pop(
                            //     context); // Navigate back or close the search page
                          },
                        ),
                        Divider(
                          height: 0,
                        ), // Add a divider after each item
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200], // Add your desired background color here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () async {
                if (_currentLocation != null && fullAddress != null)
                  await _saveLocationPreference(
                      _currentLocation!, fullAddress!);
                // Navigator.pop(context);
              },
              icon: Icons.save,
              text: 'Save Location',
            ),
          ),
        ),
      ),
    );
  }
}
