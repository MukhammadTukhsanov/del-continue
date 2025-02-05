import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/pages/category.dart';
import 'package:geo_scraper_mobile/presentation/pages/main.dart';
import 'package:geo_scraper_mobile/presentation/pages/orders.dart';
import 'package:geo_scraper_mobile/presentation/pages/profil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _bottomNavigationPages = [
    Main(),
    Category(),
    Orders(),
    Profile(), // Add SettingsPage here
  ];

  Widget _buildSvgIcon(String assetName, {required bool isSelected}) {
    return SvgPicture.asset(
      assetName,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? const Color(0xffff9556) : const Color(0x703c486b),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Ensure background color is explicitly set
            border: Border(top: BorderSide(color: Color(0xffcccdce))),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white, // Explicitly set background color
            items: [
              BottomNavigationBarItem(
                icon: _buildSvgIcon("assets/icons/home.svg",
                    isSelected: _selectedIndex == 0),
                label: 'Asosiy',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon("assets/icons/category.svg",
                    isSelected: _selectedIndex == 1),
                label: 'Kategoriya',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon("assets/icons/orders.svg",
                    isSelected: _selectedIndex == 2),
                label: 'Buyurtmalar',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon("assets/icons/profile.svg",
                    isSelected: _selectedIndex == 3),
                label: 'Profil',
              ),
            ],
            selectedItemColor: const Color(0xffff9556),
            unselectedItemColor: const Color(0x703c486b),
            selectedLabelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType
                .fixed, // Prevents shifting and background color issues
          ),
        ),
        body: _bottomNavigationPages[_selectedIndex]);
  }
}
