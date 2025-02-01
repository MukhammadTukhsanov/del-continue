import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/main_pages_header.dart';

class MarketMainPage extends StatefulWidget {
  const MarketMainPage({super.key});

  @override
  _MarketMainPageState createState() => _MarketMainPageState();
}

class _MarketMainPageState extends State<MarketMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainPagesHeader(),
          Expanded(
              child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 5),
            itemCount: menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print(menuItems[index]["text"]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 55,
                        child: Image.asset(
                          menuItems[index]["image"]!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            menuItems[index]["text"]!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff434f70),
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  )),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
