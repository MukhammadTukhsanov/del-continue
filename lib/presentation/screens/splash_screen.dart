import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/providers/address_provider.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/home.dart';
import 'package:geo_scraper_mobile/presentation/services/geocoding_service.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => initializeAddress());
  }

  Future<void> initializeAddress() async {
    try {
      // Get current location
      final position = await LocationService.getCurrentLocation();
      if (position["latitude"] == null || position["longitude"] == null) {
        throw Exception("Location data is missing");
      }

      // Get address from coordinates
      final address = await GeocodingService.getAddressFromCoordinates(
          position["latitude"]!, position["longitude"]!);
      if (address["street"] == null ||
          address["locality"] == null ||
          address["country"] == null ||
          address["region"] == null) {
        throw Exception("Incomplete address data");
      }

      await StorageService.saveUserLocation(
          position["latitude"]!, position["longitude"]!);

      await StorageService.saveAddress(address["street"]!, address["locality"]!,
          address["country"]!, address["region"]!);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Home()));
    } catch (e) {
      print('Error initializing address: $e');
      // Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get address: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
