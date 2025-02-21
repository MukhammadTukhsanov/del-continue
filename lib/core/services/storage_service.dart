import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum StorageType { markets, kitchens }

class StorageService {
  static const String _addressKey = "savedAddress";
  static const String _locationKey = "user_location";
  static const Map<StorageType, String> _storageKeys = {
    StorageType.markets: "markets_list",
    StorageType.kitchens: "kitchens_list",
  };

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

  static Future<void> saveDataLocally(
      List<Map<String, dynamic>> data, StorageType type) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String key = _storageKeys[type]!;
      await prefs.setString(key, jsonEncode(data));
      print("✅ ${type.name} saved to local storage");
    } catch (e) {
      print("❌ Error saving ${type.name} locally: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getDataFromLocal(
      StorageType type) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedData = prefs.getString(_storageKeys[type]!);
      if (storedData != null) {
        return List<Map<String, dynamic>>.from(jsonDecode(storedData));
      }
    } catch (e) {
      print("❌ Error fetching ${type.name} from local storage: $e");
    }
    return [];
  }
}
