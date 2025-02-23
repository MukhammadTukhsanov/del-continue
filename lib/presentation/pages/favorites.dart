import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/market_product_item.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<int> productCount = List.generate(5, (index) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text("Saqlanganlar"),
            bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(1), // Set the height of the border
              child: Container(
                color: const Color(0xffd8dae1), // Border color
                height: 1, // Border height
              ),
            )),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            padding: EdgeInsets.symmetric(vertical: 16),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: .753,
            crossAxisCount: 2,
            children: menuItems.asMap().entries.map((entry) {
              int index = entry.key;
              final item = entry.value;
              return SizedBox();
              // MarketProductItem(
              //     onAdd: () {}, onRemove: () {}, count: menuItems.length);
            }).toList(),
          ),
        )));
  }
}
