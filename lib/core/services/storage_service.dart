import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _addressKey = "savedAddress";
  static const String _locationKey = "user_location";
  static const String _marketsKey = "markets_list";

  static Future<void> saveUserLocation(
      double latitude, double longitude) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      Map<String, double> locationData = {
        "latitude": latitude,
        "longitude": longitude
      };

      String locationJson = jsonEncode(locationData);
      await pref.setString(_locationKey, locationJson);
      print("✅ Location saved: $locationJson");
    } catch (e) {
      print("❌ Error saving location: $e");
    }
  }

  static Future<Map<String, double>?> getUserLocation() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? locationJson = pref.getString(_locationKey);

      if (locationJson != null) {
        // Decode the JSON string back to a map
        Map<String, dynamic> decoded = jsonDecode(locationJson);
        return {
          "latitude": decoded["latitude"],
          "longitude": decoded["longitude"],
        };
      }

      return null; // Return null if no location is found
    } catch (e) {
      print("❌ Error retrieving location: $e");
      return null;
    }
  }

  static Future<void> saveAddress(
      String street, String locality, String country, String region) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String marketsJson = jsonEncode({
        "street": street,
        "locality": locality,
        "country": country,
        "region": region
      });
      await prefs.setString(_addressKey, marketsJson);
      print("✅ Address saved: $marketsJson");
    } catch (e) {
      print("❌ Error saving address: $e");
    }
  }

  static Future<Map<String, String>> getSavedAddress() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? addressJson = prefs.getString(_addressKey);

      if (addressJson != null) {
        return Map<String, String>.from(jsonDecode(addressJson));
      }
      return {}; // Return an empty map instead of null
    } catch (e) {
      print("❌ Error retrieving address: $e");
      return {};
    }
  }

  static Future<void> saveMarketsLocally(
      List<Map<String, dynamic>> markets) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_marketsKey, jsonEncode(markets));
      print("✅ Markets saved to local storage");
    } catch (e) {
      print("❌ Error saving markets locally: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getMarketsFromLocal() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedMarkets = prefs.getString(_marketsKey);
      if (storedMarkets != null) {
        return List<Map<String, dynamic>>.from(jsonDecode(storedMarkets));
      }
    } catch (e) {
      print("❌ Error fetching markets from local storage: $e");
    }
    return [];
  }
}
