import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';

class MainPagesHeader extends StatelessWidget {
  final ListItemModel listItemModel;
  const MainPagesHeader({super.key, required this.listItemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          ShimmerLoaders.imageWithShimmer(
              context, listItemModel.photo, 120, 120),
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
                      listItemModel.name,
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
                            text: listItemModel.minOrder,
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
                          "${listItemModel.minDeliveryTime} - ${listItemModel.maxDeliveryTime} min",
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
                          listItemModel.deliveryPrice,
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
                          Expanded(
                            child: Text(
                              "Tekin yetkazib berish ${listItemModel.deliveryPriceAfterFree} dan yuqori savdoda.",
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
    );
  }
}
