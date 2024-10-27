import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class LocationSharingScreen extends StatefulWidget {
  @override
  _LocationSharingScreenState createState() => _LocationSharingScreenState();
}

class _LocationSharingScreenState extends State<LocationSharingScreen> {
  String? _currentLocation;

  Future<void> _sendLocationToFirebase() async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle permission denial
        print("Location permission denied.");
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Send location to Firebase
    await FirebaseDatabase.instance
        .ref()
        .child('busLocations')
        .child('busA') // Use the specific bus ID here
        .set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    setState(() {
      _currentLocation =
          'Lat: ${position.latitude}, Lon: ${position.longitude}';
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Sharing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _sendLocationToFirebase,
              child: Text('Share My Location'),
            ),
            SizedBox(height: 20),
            if (_currentLocation != null)
              Text('Current Location: $_currentLocation'),
          ],
        ),
      ),
    );
  }
}
