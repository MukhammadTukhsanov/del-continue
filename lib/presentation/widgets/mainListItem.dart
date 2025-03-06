import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/screens/kitchen_product_item.dart';

class MainListItem extends StatelessWidget {
  final String placeName;
  final String minOrderPrice;
  final String exemplaryDeliveryTime;
  final String deliveryPrice;
  final String marketLogo;

  const MainListItem({
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SizedBox()),
        // MaterialPageRoute(builder: (context) => const KitchenMainPage()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          spacing: 10,
          children: [
            _buildMarketImage(),
            Expanded(child: _buildInfoSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: const Color(0x203c496b)),
        image: DecorationImage(
          image: NetworkImage(marketLogo),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildMinOrderPrice(),
              _buildDeliveryInfo(),
              _buildPromoBanner(),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: -4,
          child: _buildFavoriteButton(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      placeName,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildMinOrderPrice() {
    return Text.rich(
      TextSpan(
        children: [
          _textSpan("kamida - ", 0x993c486b, FontWeight.w400),
          _textSpan(minOrderPrice, 0x993c486b, FontWeight.w600),
          _textSpan(" So`m", 0x993c486b, FontWeight.w400),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      spacing: 3,
      children: [
        _buildIcon("assets/icons/clock.svg"),
        _text(" $exemplaryDeliveryTime min", 0x993c486b, 14),
        _buildIcon("assets/icons/dot.svg", width: 4, height: 4),
        _buildIcon("assets/icons/delivery.svg"),
        _text(
          deliveryPrice == "0" || deliveryPrice == "0"
              ? "Tekin"
              : deliveryPrice,
          0x703c486b,
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x803c486b)),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0x103c486b),
      ),
      child: Row(
        spacing: 6,
        children: [
          Image.asset("assets/images/persent.png", scale: 12),
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
    );
  }

  Widget _buildFavoriteButton() {
    return IconButton(
      onPressed: () {},
      icon: _buildIcon("assets/icons/heart.svg", width: 18, height: 18),
    );
  }

  Widget _buildIcon(String asset, {double width = 14, double height = 14}) {
    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      colorFilter: const ColorFilter.mode(Color(0x993c486b), BlendMode.srcIn),
      placeholderBuilder: (context) => const Icon(Icons.error),
    );
  }

  Widget _text(String text, int color, [double fontSize = 14]) {
    return Text(
      text,
      style: TextStyle(
        color: Color(color),
        fontSize: fontSize,
      ),
    );
  }

  TextSpan _textSpan(String text, int color, FontWeight fontWeight) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: Color(color),
        fontWeight: fontWeight,
      ),
    );
  }
}
