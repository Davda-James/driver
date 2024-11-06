import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationService {
  Timer? _locationUpdateTimer; // Timer to control interval updates

  Future<void> startLocationUpdates(String busId,
      {Duration interval = const Duration(seconds: 2)}) async {
    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission denied
        print("Location permission denied.");
        return;
      }
    }
    // Start the timer to send location updates at a regular interval
    _locationUpdateTimer = Timer.periodic(interval, (timer) async {
      await sendLocationToFirebase(busId);
    });
  }

  Future<void> sendLocationToFirebase(String busId) async {
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Send location to Firebase
      await FirebaseDatabase.instance
          .ref()
          .child('busLocations')
          .child(busId)
          .set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      print(
          "Location sent for $busId: Lat: ${position.latitude}, Lon: ${position.longitude}");
    } catch (e) {
      print("Failed to get location or send to Firebase: $e");
    }
  }

  void stopLocationUpdates() {
    _locationUpdateTimer
        ?.cancel(); // Stop location updates when no longer needed
  }
}
