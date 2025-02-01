import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/markets.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_main_page.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String locationMessage = "Joylashuv aniqlanyapti...";
  String street = "";
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
      street = address['street'] ?? "Ko`cha aniqlanmadi";
      locality = address['locality'] ?? "";
      country = address['country'] ?? "";
      region = address['region'] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: const Color(0xffff9556),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xffff9556),
          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          notificationPredicate: (notification) {
            return notification.depth == 1;
          },
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Address(
                    address: "$street $locality",
                    region: "$region $country",
                  ),
                  const SearchSection(),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        HeaderMenu(),
                        const Divider(
                          thickness: 1,
                          color: Color(0x203c486b),
                          height: 16,
                        ),
                        Title(title: "Oldingi buyurtmalaringiz"),
                        SizedBox(
                          height: 243,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemCount: 5,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return const ResentlyOrderedItem();
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Title(title: "Oshxonalar"),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemBuilder: (context, index) => const ListItem(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const KitchenMainPage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/1280px-Pizza-3007395.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Stack(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Domino`s Pizza",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "kamida - ",
                              style: TextStyle(
                                color: Color(0x993c486b),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "50 000",
                              style: TextStyle(
                                color: Color(0x993c486b),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: " So`m",
                              style: TextStyle(
                                color: Color(0x993c486b),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/clock.svg",
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Color(0x993c486b),
                              BlendMode.srcIn,
                            ),
                            placeholderBuilder: (BuildContext context) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            "12 - 25 min",
                            style: TextStyle(
                              color: Color(0x993c486b),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 3),
                          SvgPicture.asset(
                            "assets/icons/dot.svg",
                            width: 4,
                            height: 4,
                            colorFilter: const ColorFilter.mode(
                              Color(0x993c486b),
                              BlendMode.srcIn,
                            ),
                            placeholderBuilder: (BuildContext context) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(width: 3),
                          SvgPicture.asset(
                            "assets/icons/delivery.svg",
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Color(0x993c486b),
                              BlendMode.srcIn,
                            ),
                            placeholderBuilder: (BuildContext context) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(width: 3),
                          const Text(
                            "Tekin",
                            style: TextStyle(
                              color: Color(0x703c486b),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0x803c486b)),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0x103c486b),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/persent.png",
                              scale: 12,
                            ),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                "Tekin yetkazib berish 70 000 dan yuqori savdoda.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff3c486b),
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: -4,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/heart.svg",
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Color(0xff000000),
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder: (BuildContext context) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ResentlyOrderedItem extends StatelessWidget {
  const ResentlyOrderedItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      height: 243,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffe2e3e9)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Pizza-3007395.jpg/1280px-Pizza-3007395.jpg"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Domino`s Pizza",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xfff8b84e),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "4.0",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "(+100)",
                          style: TextStyle(
                              color: Color(0x703c486b),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "kamida - ",
                        style: TextStyle(
                            color: Color(0x993c486b),
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "50 000",
                        style: TextStyle(
                          color: Color(0x993c486b),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: " So`m",
                        style: TextStyle(
                            color: Color(0x993c486b),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/clock.svg",
                        colorFilter: const ColorFilter.mode(
                            Color(0x993c486b), BlendMode.srcIn),
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error)),
                    const SizedBox(width: 3),
                    const Text(
                      "12 - 25 min",
                      style: TextStyle(color: Color(0x993c486b), fontSize: 14),
                    ),
                    const SizedBox(width: 3),
                    SvgPicture.asset("assets/icons/dot.svg",
                        colorFilter: const ColorFilter.mode(
                            Color(0x993c486b), BlendMode.srcIn),
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error)),
                    const SizedBox(width: 3),
                    SvgPicture.asset("assets/icons/delivery.svg",
                        colorFilter: const ColorFilter.mode(
                            Color(0x993c486b), BlendMode.srcIn),
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error)),
                    const SizedBox(width: 3),
                    const Text(
                      "Tekin",
                      style: TextStyle(
                          color: Color(0x703c486b),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  String title;
  Title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
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
}

class HeaderMenu extends StatelessWidget {
  HeaderMenu({
    super.key,
  });

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                  children: [
                    Image.asset(
                      value['imagePath']!,
                      width: 70,
                      height: 64,
                    ),
                    const SizedBox(height: 3),
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
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomTextField(
        label: "Ovqatlar, Mahsulotlar",
        prefixIcon: Icons.search,
      ),
    );
  }
}

class Address extends StatelessWidget {
  final String address;
  final String region;
  const Address({super.key, required this.address, required this.region});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 32,
            color: Color(0xffffffff),
          ),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 19,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                region,
                style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
