import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<void> sendLocationToFirebase(String busId) async {
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

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Send location to Firebase
    await FirebaseDatabase.instance
        .ref()
        .child('busLocations')
        .child(busId) // Use the specific bus ID here
        .set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    print(
        "Location sent for $busId: Lat: ${position.latitude}, Lon: ${position.longitude}");
  }
}
