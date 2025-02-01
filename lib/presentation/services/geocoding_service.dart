import 'package:geocoding/geocoding.dart';

class GeocodingService {
  static Future<Map<String, String>> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // return "${place.street}, ${place.locality}, ${place.country}";
        return {
          "street": place.street!,
          "locality": place.locality!,
          "country": place.country!,
          "region": place.administrativeArea!
        };
      }
      return {"error": "No address available"};
    } catch (e) {
      return {"error": "Joylashuvni aniqlab bo'lmadi"};
    }
  }
}
