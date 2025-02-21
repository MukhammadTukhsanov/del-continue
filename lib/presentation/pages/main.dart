import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/pages/discounts.dart';
import 'package:geo_scraper_mobile/presentation/pages/markets.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontal_list_item.dart';
import 'package:geo_scraper_mobile/presentation/widgets/list_title.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

List<Map<String, dynamic>> menuItems = [
  {
    "title": "Chegirmalar",
    "imagePath": "./assets/images/persent.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Discounts()));
    }
  },
  {
    "title": "Savdo",
    "imagePath": "./assets/images/moreSales.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Markets()));
    }
  },
  {
    "title": "Kuponlarim",
    "imagePath": "./assets/images/coupon.png",
    "onTap": () {}
  },
  {
    "title": "Kel ol",
    "imagePath": "./assets/images/delive.png",
    "onTap": () {}
  },
];

class _MainState extends State<Main> {
  String street = "Ko`cha aniqlanmadi";
  String locality = "";
  String country = "";
  String region = "";

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();
    setState(() {
      street = address['street'] ?? street;
      locality = address['locality'] ?? locality;
      country = address['country'] ?? country;
      region = address['region'] ?? region;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffff9556),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xffff9556),
          onRefresh: () async =>
              Future<void>.delayed(const Duration(seconds: 3)),
          notificationPredicate: (notification) => notification.depth == 1,
          child: SingleChildScrollView(
            child: Column(
              spacing: 4,
              children: [
                _address(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    label: "Ovqatlar, Mahsulotlar",
                    prefixIcon: Icons.search_rounded,
                  ),
                ),
                _buildContentContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _address() {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/icons/marker.svg",
        color: Colors.white,
        width: 26,
      ),
      title: Text("$street, $locality",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
      subtitle: Text(
        "$region, $country",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildContentContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: menuItems.asMap().entries.map((entry) {
                var value = entry.value;
                return GestureDetector(
                  onTap: () => value['onTap'](context),
                  child: SizedBox(
                    key: ValueKey(value['title']),
                    width: MediaQuery.of(context).size.width / 4 - 8,
                    child: Center(
                      child: Column(
                        spacing: 3,
                        children: [
                          Image.asset(
                            value['imagePath']!,
                            width: 70,
                            height: 64,
                          ),
                          Text(
                            value['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(204, 60, 72, 107),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(thickness: 1, color: Color(0x203c486b), height: 16),
          ListTitle(title: "Oldingi buyurtmalaringiz"),
          _buildRecentlyOrderedList(),
          const SizedBox(height: 12),
          ListTitle(title: "Oshxonalar"),
          _buildKitchenList(),
        ],
      ),
    );
  }

  Widget _buildRecentlyOrderedList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: StorageService.getDataFromLocal(StorageType.markets),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Нет данных"));
        }
        final List<ListItemModel> displayedMarkets = snapshot.data!
            .take(3)
            .map((map) => ListItemModel.fromMap(map))
            .toList();

        return SizedBox(
          height: 243,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: displayedMarkets.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return HorizontalListItem(ListItemModel: displayedMarkets[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildKitchenList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: StorageService.getDataFromLocal(StorageType.kitchens),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Нет данных"));
        }

        final List<ListItemModel> displayedMarkets =
            snapshot.data!.map((map) => ListItemModel.fromMap(map)).toList();
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: displayedMarkets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return VerticalListItem(listItemModel: displayedMarkets[index]);
          },
        );
      },
    );
  }
}
