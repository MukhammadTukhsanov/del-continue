import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/market.dart';
import 'package:geo_scraper_mobile/presentation/state/markets_header_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/header_slider_menu.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  String locationMessage = "Joylashuv aniqlanyapti...";
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  int _activeIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getAddress();
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

  void _handleItemSelected(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: const Color(0xffd8dae1),
              )),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$street $locality',
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 19,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "$region $country",
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 16,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Title(title: "Mashhur do`konlar"),
          SizedBox(
            height: 243,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return const ResentlyOrderedItem();
              },
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xffd8dae1), height: 1),
          const SizedBox(height: 10),
          HeaderSliderMenu(
            data: marketsHeaderMenuItems,
            activeIndex: _activeIndex,
            onItemSelected: _handleItemSelected,
            scrollController: _scrollController,
          ),
          const SizedBox(height: 10),
          Title(title: marketsHeaderMenuItems[_activeIndex]["title"]!)
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
            )
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Market()));
      },
      child: Container(
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
                        style:
                            TextStyle(color: Color(0x993c486b), fontSize: 14),
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
      ),
    );
  }
}
