import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_main_page.dart';

class VerticalListItem extends StatelessWidget {
  final ListItemModel listItemModel;
  const VerticalListItem({super.key, required this.listItemModel});

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
        image: DecorationImage(
          image: NetworkImage(listItemModel.photo),
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
          Text(listItemModel.name,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: "kamida - ",
                    style: TextStyle(
                        color: Color(0x993c486b), fontWeight: FontWeight.w400)),
                TextSpan(
                    text: listItemModel.minOrder,
                    style: TextStyle(
                        color: Color(0x993c486b), fontWeight: FontWeight.w600)),
                TextSpan(
                    text: " So`m",
                    style: TextStyle(
                        color: Color(0x993c486b), fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildIcon("assets/icons/clock.svg"),
              const SizedBox(width: 3),
              Text(
                  "${listItemModel.minDeliveryTime} - ${listItemModel.maxDeliveryTime} min",
                  style: TextStyle(color: Color(0x993c486b), fontSize: 14)),
              _buildIcon("assets/icons/dot.svg"),
              _buildIcon("assets/icons/delivery.svg"),
              const SizedBox(width: 3),
              Text(listItemModel.deliveryPrice,
                  style: TextStyle(
                      color: Color(0x703c486b), fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x803c486b)),
              borderRadius: BorderRadius.circular(20),
              color: const Color(0x103c486b),
            ),
            child: Text(
              "Tekin yetkazib berish ${listItemModel.deliveryPriceAfterFree} dan yuqori savdoda.",
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff3c486b),
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
