import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/screens/onboarding.dart';
import 'package:geo_scraper_mobile/presentation/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnBoarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(MyApp(hasSeenOnBoarding: hasSeenOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnBoarding;
  const MyApp({super.key, required this.hasSeenOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "JosefinSans",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hasSeenOnBoarding ? const SplashScreen() : OnboardingPage());
  }
}
