import 'dart:convert';

import 'package:http/http.dart' as http;

class GeocodingService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';

  /// Get address from coordinates using OpenStreetMap Nominatim API
  static Future<Map<String, String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1&accept-language=uz,en',
      );

      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'GeoScraperMobile/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'] ?? {};

        return {
          'street': _extractStreet(address),
          'locality': _extractLocality(address),
          'country': address['country'] ?? "O'zbekiston",
          'region': _extractRegion(address),
        };
      } else {
        throw Exception('Failed to fetch address: ${response.statusCode}');
      }
    } catch (e) {
      print('Geocoding error: $e');

      // Return default address for Bukhara region if API fails
      return {
        'street': 'Noma\'lum ko\'cha',
        'locality': 'Buxoro',
        'country': "O'zbekiston",
        'region': 'Buxoro viloyati',
      };
    }
  }

  /// Get coordinates from address (forward geocoding)
  static Future<Map<String, double>> getCoordinatesFromAddress(
    String address,
  ) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/search?format=json&q=${Uri.encodeComponent(address)}&limit=1&countrycodes=uz',
      );

      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'GeoScraperMobile/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          return {
            'latitude': double.parse(data[0]['lat']),
            'longitude': double.parse(data[0]['lon']),
          };
        }
      }

      throw Exception('Address not found');
    } catch (e) {
      print('Geocoding error: $e');

      // Return Bukhara center coordinates as fallback
      return {
        'latitude': 39.7681,
        'longitude': 64.4221,
      };
    }
  }

  static String _extractStreet(Map<String, dynamic> address) {
    // Try different street field names
    return address['road'] ??
        address['street'] ??
        address['pedestrian'] ??
        address['path'] ??
        'Noma\'lum ko\'cha';
  }

  static String _extractLocality(Map<String, dynamic> address) {
    // Try different locality field names
    return address['city'] ??
        address['town'] ??
        address['village'] ??
        address['suburb'] ??
        address['neighbourhood'] ??
        'Buxoro';
  }

  static String _extractRegion(Map<String, dynamic> address) {
    // Try different region field names
    return address['state'] ??
        address['province'] ??
        address['region'] ??
        'Buxoro viloyati';
  }
}
