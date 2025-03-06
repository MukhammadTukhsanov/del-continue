import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/data/models/market_product_item_model.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';

class MarketProductItem extends StatefulWidget {
  final MarketProductItemModel marketProductItemModel;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;

  const MarketProductItem(
      {super.key,
      required this.marketProductItemModel,
      required this.onAdd,
      required this.onRemove,
      required this.count});

  @override
  _MarketProductItemState createState() => _MarketProductItemState();
}

class _MarketProductItemState extends State<MarketProductItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ShimmerLoaders.imageWithShimmer(
                context,
                widget.marketProductItemModel.photo,
                MediaQuery.sizeOf(context).width / 2 - 10,
                MediaQuery.sizeOf(context).width / 2 - 10),
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(Radius.circular(36)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(25, 0, 0, 0),
                              spreadRadius: 0,
                              blurRadius: 4)
                        ]),
                    child: Row(
                      children: [
                        if (widget.count != 0)
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: Center(
                              child: IconButton(
                                  iconSize: 26,
                                  color: const Color(0xff3c486b),
                                  padding: const EdgeInsets.all(0),
                                  onPressed: widget.onRemove,
                                  icon: const Icon(Icons.remove)),
                            ),
                          ),
                        if (widget.count != 0)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 32, // Matches the height of the buttons
                                child: Center(
                                  child: Text(
                                    "${widget.count}",
                                    key: ValueKey<int>(widget.count),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff3c486b),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: IconButton(
                                iconSize: 26,
                                color: const Color(0xff3c486b),
                                padding: const EdgeInsets.all(0),
                                onPressed: widget.onAdd,
                                icon: const Icon(Icons.add)),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Expanded(
              child: Text(widget.marketProductItemModel.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3c486b))),
            ),
            Text(
                "${widget.marketProductItemModel.measurementValue}${widget.marketProductItemModel.unitOfMeasure}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3c486b))),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          widget.marketProductItemModel.description,
          style: TextStyle(
              color: Color.fromARGB(153, 60, 72, 107),
              fontSize: 14,
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 2),
        Text(
          "${widget.marketProductItemModel.price} so`m",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff3c486b)),
        )
      ],
    );
  }
}
