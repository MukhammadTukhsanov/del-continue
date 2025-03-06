import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ShimmerLoadersItems { horizontalListItemShimmer, verticalListItemShimmer }

class ShimmerLoaders {
  static Widget buildShimmerList(
      BuildContext context, ShimmerLoadersItems shimmerType) {
    if (shimmerType == ShimmerLoadersItems.horizontalListItemShimmer) {
      return SizedBox(
        height: 243,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) => _horizontalListItemShimmer(context),
        ),
      );
    } else if (shimmerType == ShimmerLoadersItems.verticalListItemShimmer) {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) => _verticalListItemShimmer(context),
      );
    } else {
      return SizedBox();
    }
  }

  static Widget _horizontalListItemShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 310),
        width: MediaQuery.of(context).size.width * .75,
        height: 243,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffe2e3e9)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _shimmerBox(width: 120, height: 17),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 20),
                          const SizedBox(width: 5),
                          _shimmerBox(width: 20, height: 17),
                          const SizedBox(width: 10),
                          _shimmerBox(width: 50, height: 17),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _shimmerBox(width: 50, height: 14),
                      const Text(" - ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17)),
                      _shimmerBox(width: 80, height: 14),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      _shimmerBox(width: 14, height: 13),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 20, height: 14),
                      const Text(" - ",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      _shimmerBox(width: 30, height: 17),
                      const SizedBox(width: 3),
                      SvgPicture.asset(
                        "assets/icons/dot.svg",
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 20, height: 17),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 30, height: 17),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _verticalListItemShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shimmerBox(width: 130, height: 17),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _shimmerBox(width: 70, height: 14),
                      Text(" - ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      _shimmerBox(width: 130, height: 14),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _shimmerBox(width: 14, height: 14),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 17, height: 14),
                      Text(" - ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      _shimmerBox(width: 27, height: 14),
                      SvgPicture.asset(
                        "assets/icons/dot.svg",
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 20, height: 17),
                      const SizedBox(width: 3),
                      _shimmerBox(width: 30, height: 17),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _shimmerBox(
                      width: MediaQuery.sizeOf(context).width, height: 20)
                  // Row(
                  //   children: [
                  //     _buildIcon("assets/icons/clock.svg"),
                  //     const SizedBox(width: 3),
                  //     Text(
                  //         "${listItemModel.minDeliveryTime} - ${listItemModel.maxDeliveryTime} min",
                  //         style: TextStyle(color: Color(0x993c486b), fontSize: 14)),
                  //     _buildIcon("assets/icons/dot.svg"),
                  //     _buildIcon("assets/icons/delivery.svg"),
                  //     const SizedBox(width: 3),
                  //     Text(listItemModel.deliveryPrice,
                  //         style: TextStyle(
                  //             color: Color(0x703c486b), fontWeight: FontWeight.w400)),
                  //   ],
                  // ),
                  // const SizedBox(height: 6),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: const Color(0x803c486b)),
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: const Color(0x103c486b),
                  //   ),
                  //   child: Text(
                  //     "Tekin yetkazib berish ${listItemModel.deliveryPriceAfterFree} dan yuqori savdoda.",
                  //     style: TextStyle(
                  //         fontSize: 13,
                  //         color: Color(0xff3c486b),
                  //         fontWeight: FontWeight.w600),
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Reusable shimmer box
  static Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
