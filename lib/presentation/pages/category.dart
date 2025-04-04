import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/filtred_markets.dart';
import 'package:geo_scraper_mobile/presentation/state/category_header_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  List data = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    await _getAddress();
    data = [
      ...await StorageService.getDataFromLocal(StorageType.kitchens),
      ...await StorageService.getDataFromLocal(StorageType.markets)
    ];
  }

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();

    setState(() {
      street = address['street'] ?? "";
      locality = address['locality'] ?? "";
      country = address['country'] ?? "";
      region = address['region'] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$street $locality',
              style: const TextStyle(
                  color: Color(0xff3c486b),
                  fontSize: 19,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "$region $country",
              style: const TextStyle(
                  color: Color(0xff3c486b),
                  fontSize: 16,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/edit.svg",
                width: 28,
              ))
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffd8dae1)))),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Adjust as needed
                  children: categoryHeaderMenuItems
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FiltredMarkets(
                                  title: e["title"] ?? "",
                                  data: data
                                      .where(
                                          (market) => market["type"] == e["id"])
                                      .toList(),
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxWidth: 85),
                                width: 85, // Adjust width if needed
                                height: 65,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(e["image"] ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8), // ✅ Proper spacing
                              Text(
                                e["title"] ?? "",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff3c486b),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(), // ✅ Convert map() to list
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Text(
                      "Barchasi",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3c486b)),
                    ),
                  ),
                  FutureBuilder<List<List<Map<String, dynamic>>>>(
                    future: Future.wait([
                      StorageService.getDataFromLocal(StorageType.markets),
                      StorageService.getDataFromLocal(StorageType.kitchens),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerLoaders.buildShimmerList(context,
                            ShimmerLoadersItems.verticalListItemShimmer,
                            count: 6);
                      }
                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return Center(child: Text("Нет данных"));
                      }

                      final List<ListItemModel> displayedMarkets = [
                        ...snapshot.data![0]
                            .map((map) => ListItemModel.fromMap(map)),
                        ...snapshot.data![1]
                            .map((map) => ListItemModel.fromMap(map))
                      ]..shuffle();

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(bottom: 12),
                        itemCount: displayedMarkets.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return VerticalListItem(
                              listItemModel: displayedMarkets[index]);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

          // MainListItem(
          //   deliveryPrice: "0",
          //   marketLogo:
          //       "https://marketing.uz/uz/uploads/articles/1233/article-original.jpg",
          //   exemplaryDeliveryTime: "12 - 25",
          //   minOrderPrice: "10 000",
          //   placeName: "Korzinka",
          // )