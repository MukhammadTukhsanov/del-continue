import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
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

  final List<Widget> _pages = [
    Main(),
    Category(),
    Orders(),
    Profile(),
  ];

  final List<Map<String, String>> _navItems = [
    {'icon': "assets/icons/home.svg", 'label': 'Asosiy'},
    {'icon': "assets/icons/category.svg", 'label': 'Kategoriya'},
    {'icon': "assets/icons/orders.svg", 'label': 'Buyurtmalar'},
    {'icon': "assets/icons/profile.svg", 'label': 'Profil'},
  ];

  @override
  void initState() {
    super.initState();
    loadMarkets();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void loadMarkets() async {
    List<Map<String, dynamic>> markets =
        await StorageService.getDataFromLocal(StorageType.markets);

    if (markets.isNotEmpty) {
      print("📥 Loaded markets from local storage:");
      print(markets);
    } else {
      print("⚠ No markets found in local storage.");
    }
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  Widget _buildSvgIcon(String assetName, bool isSelected) {
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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: _navItems.map((item) {
          int index = _navItems.indexOf(item);
          return BottomNavigationBarItem(
            icon: _buildSvgIcon(item['icon']!, _selectedIndex == index),
            label: item['label'],
          );
        }).toList(),
        selectedItemColor: const Color(0xffff9556),
        unselectedItemColor: const Color(0x703c486b),
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
