import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/screens/market_main_page.dart';
import 'package:shimmer/shimmer.dart';

// You'll need to create this model for review data
class ReviewModel {
  final String userName;
  final String orderId;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.userName,
    required this.orderId,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class HorizontalListItem extends StatelessWidget {
  final ListItemModel listItemModel;
  // Add this parameter to pass reviews data
  final List<ReviewModel>? reviews;

  const HorizontalListItem({
    super.key,
    required this.listItemModel,
    this.reviews,
  });

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
                          GestureDetector(
                              onTap: () => _showReviewsBottomSheet(context),
                              child: Row(children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: Color(0x703c486b),
                                  size: 20,
                                ),
                                Text(
                                  "(+${listItemModel.reviewsCount})",
                                  style: const TextStyle(
                                      color: Color(0x703c486b),
                                      fontWeight: FontWeight.w600),
                                ),
                              ]))
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

  void _showReviewsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sharhlar',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Reviews list
            Expanded(
              child: reviews != null && reviews!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: reviews!.length,
                      itemBuilder: (context, index) =>
                          _buildReviewItem(reviews![index]),
                    )
                  : const Center(
                      child: Text(
                        'Hozircha sharhlar yo\'q',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(ReviewModel review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _maskUserName(review.userName),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                'Buyurtma: ${review.orderId}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review.rating.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: const Color(0xfff8b84e),
                  size: 16,
                );
              }),
              const SizedBox(width: 8),
              Text(
                review.rating.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatDate(review.date),
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _maskUserName(String userName) {
    if (userName.length <= 2) return userName;

    String firstChar = userName[0];
    String lastChar = userName[userName.length - 1];
    String maskedMiddle = '*' * (userName.length - 2);

    return '$firstChar$maskedMiddle$lastChar';
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
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
