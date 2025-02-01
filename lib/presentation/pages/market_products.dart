import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/pages/basket.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/header_slider_menu.dart';
import 'package:geo_scraper_mobile/presentation/widgets/market_product_item.dart';

class MarketProducts extends StatefulWidget {
  int activeIndex = 0;
  MarketProducts({super.key, required this.activeIndex});

  @override
  _MarketProductsState createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
  }

  List<int> productCount = List.generate(5, (index) => 0);

  void addProductCount(int index) {
    setState(() {
      productCount[index]++;
    });
  }

  void removeProductCount(int index) {
    setState(() {
      productCount[index]--;
    });
  }

  void _handleItemSelected(int index) {
    setState(() {
      widget.activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              HeaderSliderMenu(
                  data: menuItems,
                  activeIndex: widget.activeIndex,
                  onItemSelected: _handleItemSelected),
              const SizedBox(height: 10),
              const Divider(color: Color(0xffd8dae1), height: 1),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 12,
                      childAspectRatio: .74),
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return MarketProductItem(
                      count: productCount[index],
                      onAdd: () => addProductCount(index),
                      onRemove: () => removeProductCount(index),
                    );
                  }),
                ),
              )),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Color(0x203c486b)))),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/persent.png",
                          scale: 12,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "90 000 So`mdan keyin bepul yetkarip beriladi",
                          style: TextStyle(
                              color: Color(0xff3c486b),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: 0.1,
                      backgroundColor: const Color(0xffd9d9d9),
                      color: const Color(0xffff9556),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffff9556), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(6), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize:
                            const Size(double.infinity, 36), // Full width
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Basket(basketData: [{}])));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              "Savatingizni ko`ring",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 115,
                            child: Text(
                              "10 000 So`m",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
