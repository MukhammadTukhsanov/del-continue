import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/markets.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_main_page.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontalListItem.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

List<Map<String, dynamic>> menuItems = [
  {
    "title": "Chegirmalar",
    "imagePath": "./assets/images/persent.png",
    "onTap": () {}
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
          _title("Oldingi buyurtmalaringiz"),
          _buildRecentlyOrderedList(),
          const SizedBox(height: 12),
          _title("Oshxonalar"),
          _buildKitchenList(),
        ],
      ),
    );
  }

  Widget _title(title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xff3c486b),
                  fontWeight: FontWeight.w600),
            ),
            Image.asset(
              "assets/icons/arrow.png",
              scale: 3,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyOrderedList() {
    return SizedBox(
      height: 243,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 5,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, __) => const HorizontalListItem()
          // RecentlyOrderedItem(),
          ),
    );
  }

  Widget _buildKitchenList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, __) => const ListItem(),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const KitchenMainPage())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            _buildImage(),
            const SizedBox(width: 10),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/1280px-Pizza-3007395.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Domino`s Pizza",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          const SizedBox(height: 6),
          _buildPriceText(),
          const SizedBox(height: 6),
          _buildDeliveryInfo(),
          const SizedBox(height: 6),
          _buildPromoBadge(),
        ],
      ),
    );
  }

  Widget _buildPriceText() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: "kamida - ",
              style: TextStyle(
                  color: Color(0x993c486b), fontWeight: FontWeight.w400)),
          TextSpan(
              text: "50 000",
              style: TextStyle(
                  color: Color(0x993c486b), fontWeight: FontWeight.w600)),
          TextSpan(
              text: " So`m",
              style: TextStyle(
                  color: Color(0x993c486b), fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      children: [
        _buildIcon("assets/icons/clock.svg"),
        const SizedBox(width: 3),
        const Text("12 - 25 min",
            style: TextStyle(color: Color(0x993c486b), fontSize: 14)),
        _buildIcon("assets/icons/dot.svg"),
        _buildIcon("assets/icons/delivery.svg"),
        const SizedBox(width: 3),
        const Text("Tekin",
            style: TextStyle(
                color: Color(0x703c486b), fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget _buildPromoBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x803c486b)),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0x103c486b),
      ),
      child: const Text(
        "Tekin yetkazib berish 70 000 dan yuqori savdoda.",
        style: TextStyle(
            fontSize: 13,
            color: Color(0xff3c486b),
            fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildIcon(String path) {
    return SvgPicture.asset(path,
        width: 14,
        height: 14,
        colorFilter:
            const ColorFilter.mode(Color(0x993c486b), BlendMode.srcIn));
  }
}
