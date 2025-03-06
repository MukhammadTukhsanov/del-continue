import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/market_product_item_model.dart';

class KitchenMainPage extends StatefulWidget {
  final MarketProductItemModel marketProductItemModel;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;
  const KitchenMainPage(
      {super.key,
      required this.marketProductItemModel,
      required this.onAdd,
      required this.onRemove,
      required this.count});

  @override
  _KitchenMainPageState createState() => _KitchenMainPageState();
}

class _KitchenMainPageState extends State<KitchenMainPage> {
  String locationMessage = "Joylashuv aniqlanyapti...";
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  @override
  void initState() {
    super.initState();
    print("product item");
    _getAddress();
  }

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();

    setState(() {
      street = address['street']!;
      locality = address['locality']!;
      country = address['country']!;
      region = address['region']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffd8dae1)),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.marketProductItemModel.photo,
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.marketProductItemModel.name,
                style: TextStyle(
                    color: Color(0xff3c486b),
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "${widget.marketProductItemModel.measurementValue} ${widget.marketProductItemModel.unitOfMeasure}",
                style: TextStyle(
                    color: Color(0xff3c486b),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Text(
                  widget.marketProductItemModel.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(160, 60, 72, 107)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.marketProductItemModel.price} so'm",
                    style: TextStyle(
                        color: Color(0xff3c486b),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(50, 0, 0, 0),
                              spreadRadius: 1,
                              blurRadius: 4),
                        ]),
                    child: Row(
                      children: [
                        if (widget.count != 0)
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Center(
                              child: IconButton(
                                  iconSize: 22,
                                  color: const Color(0xff3c486b),
                                  padding: const EdgeInsets.all(0),
                                  onPressed: widget.onRemove,
                                  icon: const Icon(Icons.remove)),
                            ),
                          ),
                        if (widget.count != 0)
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    "${widget.count}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                          width: 30,
                          height: 30,
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
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
