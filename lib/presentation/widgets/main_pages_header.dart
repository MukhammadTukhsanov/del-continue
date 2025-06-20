import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontal_list_item.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';

class MainPagesHeader extends StatelessWidget {
  final ListItemModel listItemModel;
  final List<ReviewModel>? reviews;
  const MainPagesHeader({super.key, required this.listItemModel, this.reviews});

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
                  top: 0,
                  child: GestureDetector(
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
                      ]))),
            ]),
          ),
        ],
      ),
    );
  }
}
