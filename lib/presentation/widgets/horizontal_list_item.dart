import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';

class HorizontalListItem extends StatelessWidget {
  final ListItemModel listItemModel;
  const HorizontalListItem({super.key, required this.listItemModel});

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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(listItemModel.photo),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listItemModel.name,
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
                          listItemModel.rating,
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "(+${listItemModel.reviewsCount})",
                          style: TextStyle(
                              color: Color(0x703c486b),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "kamida - ",
                        style: TextStyle(
                            color: Color(0x993c486b),
                            fontWeight: FontWeight.w400),
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
                    Text(
                      "${listItemModel.minDeliveryTime} - ${listItemModel.maxDeliveryTime} min",
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
                    Text(
                      listItemModel.deliveryPrice,
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
