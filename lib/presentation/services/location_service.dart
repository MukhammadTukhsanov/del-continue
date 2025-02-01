import 'package:geolocator/geolocator.dart';

class LocationService {
  // Change return type to Map<String, double>
  static Future<Map<String, double>> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {'error': -1}; // Error code for location services not enabled
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {'error': -2}; // Error code for denied permission
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return {'error': -3}; // Error code for permanently denied permission
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Return the latitude and longitude as a Map
    return {'latitude': position.latitude, 'longitude': position.longitude};
  }
}
