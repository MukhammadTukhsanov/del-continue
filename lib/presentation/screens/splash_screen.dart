import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/firebase_database_service.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/home.dart';
import 'package:geo_scraper_mobile/presentation/services/geocoding_service.dart';

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
    fetchData();
    Future.microtask(() => initializeAddress());
  }

  void fetchData() async {
    FirebaseDatabaseService databaseService = FirebaseDatabaseService();
    await databaseService.fetchMarkets();
    await databaseService.fetchKitchens();
  }

  Future<void> initializeAddress() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position["latitude"] == null || position["longitude"] == null) {
        throw Exception("Location data is missing");
      }

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
    return Scaffold(
      backgroundColor: Color(0xffff9556),
      body: Center(
          child: SvgPicture.asset(
        "assets/images/logo_yo'lda.svg",
        width: MediaQuery.sizeOf(context).width * .75,
      )),
    );
  }
}
