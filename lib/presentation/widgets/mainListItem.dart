import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_main_page.dart';

class MainListItem extends StatelessWidget {
  String placeName;
  String minOrderPrice;
  String exemplaryDeliveryTime;
  String deliveryPrice;
  String marketLogo;

  MainListItem({
    required this.deliveryPrice,
    required this.exemplaryDeliveryTime,
    required this.marketLogo,
    required this.minOrderPrice,
    required this.placeName,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: Color(0x203c496b)),
                image: DecorationImage(
                  image: NetworkImage(marketLogo),
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
                      Text(
                        placeName,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text.rich(
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
                              text: minOrderPrice,
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
                          Text(
                            "$exemplaryDeliveryTime min",
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
                          Text(
                            deliveryPrice == "0" || deliveryPrice == 0
                                ? "Tekin"
                                : deliveryPrice,
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
