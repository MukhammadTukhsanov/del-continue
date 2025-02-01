import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/widgets/main_pages_header.dart';

class KitchenMainPage extends StatefulWidget {
  const KitchenMainPage({super.key});

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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: const Color(0xffd8dae1),
                )),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$street $locality',
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 19,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "$region $country",
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 16,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const MainPagesHeader(),
              const Divider(
                height: 1,
                color: Color(0x203c486b),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xffd8dae1)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      "https://grill-bbq.ru/wp-content/uploads/2021/07/shashlyk-iz-kuritsy.jpg",
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
                                const Text(
                                  "Shashlik",
                                  style: TextStyle(
                                      color: Color(0xff3c486b),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  "1 portsiya",
                                  style: TextStyle(
                                      color: Color(0xff3c486b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text(
                                  "Tuz, sabzi, un",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(160, 60, 72, 107)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "23 000 so'm",
                                      style: TextStyle(
                                          color: Color(0xff3c486b),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Color.fromARGB(50, 0, 0, 0),
                                                spreadRadius: 1,
                                                blurRadius: 4),
                                          ]),
                                      child: Row(
                                        children: [
                                          // if (widget.count != 0)
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Center(
                                              child: IconButton(
                                                  iconSize: 22,
                                                  color:
                                                      const Color(0xff3c486b),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  // onPressed: widget.onRemove,
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.remove)),
                                            ),
                                          ),
                                          // if (widget.count != 0)
                                          const AnimatedSwitcher(
                                            duration:
                                                Duration(milliseconds: 300),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: SizedBox(
                                                height:
                                                    30, // Matches the height of the buttons
                                                child: Center(
                                                  child: Text(
                                                    // "${widget.count}",
                                                    "1",
                                                    // key:
                                                    // ValueKey<int>(widget.count),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xff3c486b),
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  color:
                                                      const Color(0xff3c486b),
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  // onPressed: widget.onAdd,
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.add)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
