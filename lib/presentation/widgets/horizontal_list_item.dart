import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/screens/market_main_page.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalListItem extends StatelessWidget {
  final ListItemModel listItemModel;
  const HorizontalListItem({super.key, required this.listItemModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MarketMainPage(
                    listItemModel: listItemModel,
                  ))),
      child: Container(
        constraints: BoxConstraints(maxWidth: 310),
        width: MediaQuery.of(context).size.width * .75,
        height: 243,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffe2e3e9)),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildShimmerOrImage(listItemModel.photo),
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
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xfff8b84e), size: 20),
                          const SizedBox(width: 5),
                          Text(
                            listItemModel.rating,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "(+${listItemModel.reviewsCount})",
                            style: const TextStyle(
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
                        const TextSpan(
                          text: "kamida - ",
                          style: TextStyle(
                              color: Color(0x993c486b),
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: listItemModel.minOrder,
                          style: const TextStyle(
                            color: Color(0x993c486b),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
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
                        style: const TextStyle(
                            color: Color(0x993c486b), fontSize: 14),
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
                        style: const TextStyle(
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

  Widget _buildShimmerOrImage(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: FutureBuilder(
        future: _preloadImage(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => _errorPlaceholder(),
            );
          }
          return _shimmerPlaceholder();
        },
      ),
    );
  }

  Future<void> _preloadImage(String url) async {
    final ImageStream stream =
        NetworkImage(url).resolve(const ImageConfiguration());
    final Completer<void> completer = Completer();

    stream.addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) => completer.complete(),
        onError: (dynamic error, StackTrace? stackTrace) {
          debugPrint("Ошибка загрузки изображения: $error");
          completer.complete();
        },
      ),
    );

    return completer.future;
  }

  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _errorPlaceholder() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, color: Colors.grey),
    );
  }
}
