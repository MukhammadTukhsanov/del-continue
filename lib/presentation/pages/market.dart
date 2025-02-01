import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/main_pages_header.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Savdo"),
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(1), // Set the height of the border
            child: Container(
              color: const Color(0xffd8dae1), // Border color
              height: 1, // Border height
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            const MainPagesHeader(),
            const Divider(
              height: 1,
              color: Color(0xffd8dae1),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: menuItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    final item = entry.value;
                    return GestureDetector(
                      onTap: () => item["onTap"](context, index),
                      key: ValueKey("${item["imageSrc"]} + $index"),
                      child: Column(
                        children: [
                          Container(
                            width: 75,
                            height: 55,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item["imageSrc"]!))),
                          ),
                          SizedBox(
                            width: 75,
                            height: 47,
                            child: Center(
                              child: Text(
                                item["title"]!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList()),
            )
          ],
        )));
  }
}
