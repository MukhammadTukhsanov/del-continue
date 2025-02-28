import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/data/models/market_product_item_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/market_products.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/main_pages_header.dart';

class MarketMainPage extends StatefulWidget {
  final ListItemModel listItemModel;
  const MarketMainPage({super.key, required this.listItemModel});

  @override
  State<MarketMainPage> createState() => _MarketMainPageState();
}

class _MarketMainPageState extends State<MarketMainPage> {
  List<MarketProductItemModel> products = [];
  @override
  void initState() {
    super.initState();
  }

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
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: const Color(0xffd8dae1),
              height: 1,
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            MainPagesHeader(
              listItemModel: widget.listItemModel,
            ),
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarketProducts(
                                  activeIndex: index,
                                  id: widget.listItemModel.id,
                                  afterFree: widget
                                      .listItemModel.deliveryPriceAfterFree,
                                  deliveryPrice:
                                      widget.listItemModel.deliveryPrice))),
                      key: ValueKey("${item["imageSrc"]} + $index"),
                      child: Column(
                        children: [
                          Container(
                            width: 75,
                            height: 55,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item["image"]!))),
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
