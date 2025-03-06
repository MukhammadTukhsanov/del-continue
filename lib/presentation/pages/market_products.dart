import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_product_item.dart';
import 'package:geo_scraper_mobile/presentation/utils/number_format.dart';
import 'package:geo_scraper_mobile/presentation/utils/remove_spaces_and_convert_to_int.dart';
import 'package:geo_scraper_mobile/core/services/firebase_database_service.dart';
import 'package:geo_scraper_mobile/data/models/market_product_item_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/basket.dart';
import 'package:geo_scraper_mobile/presentation/state/market_main_page_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/header_slider_menu.dart';
import 'package:geo_scraper_mobile/presentation/widgets/main_pages_header.dart';
import 'package:geo_scraper_mobile/presentation/widgets/market_product_item.dart';

class MarketProducts extends StatefulWidget {
  final String id;
  final int activeIndex;
  final String afterFree;
  final String deliveryPrice;
  final String type;

  final ListItemModel? listItemModel;

  const MarketProducts({
    super.key,
    required this.activeIndex,
    required this.id,
    required this.afterFree,
    required this.deliveryPrice,
    this.listItemModel,
    this.type = "",
  });

  @override
  _MarketProductsState createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts> {
  List originalProducts = [];
  List products = [];
  List basket = [];

  int activeIndex = 0;
  int intAfterFreeDelivery = 0;

  bool isDeliveryFree = false;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.activeIndex;
    intAfterFreeDelivery = removeSpacesAndConvertToInt(widget.afterFree);
    print("type: ${widget.type}");
    fetchSingleMarket(widget.id);
  }

  Future<void> fetchSingleMarket(String id) async {
    FirebaseDatabaseService databaseService = FirebaseDatabaseService();
    List<Map<String, dynamic>>? productsData =
        await databaseService.fetchSingleMarket(
            id, widget.type == "kitchen" ? "kitchens" : "markets");

    if (productsData != null) {
      setState(() {
        originalProducts =
            productsData.map((e) => MarketProductItemModel.fromMap(e)).toList();
        _handleHeaderFilter(activeIndex);
      });
    } else {
      print("No products found");
    }
  }

  int totalProductCount = 0;
  int totalPrice = 0;

  void checkIsDeliveryFree() {
    if (totalPrice >= removeSpacesAndConvertToInt(widget.afterFree)) {
      setState(() {
        isDeliveryFree = true;
      });
    } else {
      setState(() {
        isDeliveryFree = false;
      });
    }
  }

  void addProductCount(String productId, String price, product) {
    int intPrice = removeSpacesAndConvertToInt(price);
    int index = basket.indexWhere((item) => item.id == product.id);

    setState(() {
      if (index != -1) {
        basket[index].count += 1;
      } else {
        product.count = 1;
        basket.add(product);
      }
      totalProductCount++;
      totalPrice += intPrice;
    });
    checkIsDeliveryFree();
  }

  void removeProductCount(String productId, String price) {
    int intPrice = removeSpacesAndConvertToInt(price);
    int index = basket.indexWhere((item) => item.id == productId);

    if (index != -1) {
      setState(() {
        basket[index].count -= 1;
        totalProductCount--;
        totalPrice -= intPrice;

        if (basket[index].count == 0) {
          basket.removeAt(index);
        }
      });
    }
    checkIsDeliveryFree();
  }

  void _handleHeaderFilter(int index) {
    if (index < 0 || index >= menuItems.length) return;

    setState(() {
      activeIndex = index;
      products = (index == 0)
          ? List.from(originalProducts)
          : originalProducts
              .where((e) => e.type == menuItems[index]["id"])
              .toList();
    });
  }

  void goToBasket() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Basket(
            totalPrice: totalPrice,
            data: basket,
            id: widget.id,
            deliveryPrice: widget.deliveryPrice,
            afterFree: widget.afterFree,
            isDeliveryFree: isDeliveryFree),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        totalPrice = result['newtotalPrice'];
        isDeliveryFree = result['isDeliveryFree'];
        basket = (result['updatedProducts'] as List<dynamic>)
            .map((e) => MarketProductItemModel.fromMap(e))
            .toList();
      });
    }
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
              if (widget.type == "kitchen" || widget.type == "one-type")
                MainPagesHeader(listItemModel: widget.listItemModel!),
              if (widget.type.isEmpty)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    HeaderSliderMenu(
                      data: menuItems,
                      activeIndex: widget.activeIndex,
                      onItemSelected: _handleHeaderFilter,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              const Divider(color: Color(0xffd8dae1), height: 1),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.type == "kitchen" ? 1 : 2,
                      mainAxisSpacing: widget.type == "kitchen" ? 20 : 10,
                      crossAxisSpacing: 12,
                      childAspectRatio: widget.type == "kitchen" ? 3.65 : .67),
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    final product = products[index];
                    int count = 0;

                    try {
                      count = basket
                          .firstWhere((item) => item.id == product.id)
                          .count;
                    } catch (e) {
                      count = 0;
                    }
                    if (widget.type == 'kitchen') {
                      return KitchenMainPage(
                        count: count,
                        onAdd: () =>
                            addProductCount(product.id, product.price, product),
                        onRemove: () =>
                            removeProductCount(product.id, product.price),
                        marketProductItemModel: product,
                      );
                    } else {
                      return MarketProductItem(
                        count: count,
                        onAdd: () =>
                            addProductCount(product.id, product.price, product),
                        onRemove: () =>
                            removeProductCount(product.id, product.price),
                        marketProductItemModel: product,
                      );
                    }
                  }),
                ),
              )),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      )),
                      child: child,
                    );
                  },
                  child: (totalPrice > 0 && totalProductCount > 0)
                      ? Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(color: Color(0x203c486b)))),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              (isDeliveryFree)
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 20,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Sizga bepul yetkazip beriladi.",
                                          style: TextStyle(
                                              color: Color(0xff3c486b),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/persent.png",
                                          scale: 12,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${formatNumber(intAfterFreeDelivery - totalPrice)} So`mdan keyin bepul yetkarip beriladi",
                                          style: TextStyle(
                                              color: Color(0xff3c486b),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                              const SizedBox(height: 8),
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: ((totalPrice * 100) /
                                          intAfterFreeDelivery) /
                                      100,
                                ),
                                builder: (context, value, child) {
                                  return LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(10),
                                      value: value,
                                      backgroundColor: const Color(0xffd9d9d9),
                                      color: (isDeliveryFree)
                                          ? Colors.green
                                          : const Color(0xffff9556));
                                },
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffff9556),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  minimumSize: const Size(double.infinity, 36),
                                ),
                                onPressed: goToBasket,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "$totalProductCount",
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
                                    SizedBox(
                                      width: 115,
                                      child: Text(
                                        "${formatNumber(totalPrice)} So`m",
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
                      : SizedBox())
            ],
          ),
        ));
  }
}
