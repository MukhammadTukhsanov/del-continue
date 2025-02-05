import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/widgets/mainListItem.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String locationMessage = "Joylashuv aniqlanyapti...";
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  @override
  void initState() {
    super.initState();
    _getAddress();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
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
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                      child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/moreSales.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text("Savdo",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff3c486b),
                              fontWeight: FontWeight.w600))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/water.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text("Suv",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff3c486b),
                              fontWeight: FontWeight.w600))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/meat.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text("Go`sht",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff3c486b),
                              fontWeight: FontWeight.w600))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/foods.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text("Go`sht",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff3c486b),
                              fontWeight: FontWeight.w600))
                    ],
                  )),
                ],
              ),
            ),
            Divider(
              color: Color(0x203c496b),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Mashxur do`konlar",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3c486b)),
              ),
            ),
            MainListItem(
              deliveryPrice: "0",
              marketLogo:
                  "https://marketing.uz/uz/uploads/articles/1233/article-original.jpg",
              exemplaryDeliveryTime: "12 - 25",
              minOrderPrice: "10 000",
              placeName: "Korzinka",
            )
          ],
        ),
      )),
    );
  }
}
