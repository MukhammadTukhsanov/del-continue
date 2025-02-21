import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/state/markets_header_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/header_slider_menu.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontal_list_item.dart';
import 'package:geo_scraper_mobile/presentation/widgets/list_title.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  String locationMessage = "Joylashuv aniqlanyapti...";
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  int _activeIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getMarkets();
    _getAddress();
  }

  List<ListItemModel> _markets = [];
  final List<ListItemModel> _filteredMarkets = [];
  final String _activeCategory = "all";

  Future<void> _getMarkets() async {
    final data = await StorageService.getDataFromLocal(StorageType.markets);

    setState(() {
      _markets = data.map((map) {
        print("map: $map");
        return ListItemModel.fromMap(map);
      }).toList();
    });
  }

  _handleFilterChange() {}

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();

    setState(() {
      street = address['street'] ?? "";
      locality = address['locality'] ?? "";
      country = address['country'] ?? "";
      region = address['region'] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        children: [
          const SizedBox(height: 16),
          ListTitle(title: "Mashhur do`konlar", icon: false),
          SizedBox(
            height: 243,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _markets.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return HorizontalListItem(ListItemModel: _markets[index]);
              },
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xffd8dae1), height: 1),
          const SizedBox(height: 10),
          HeaderSliderMenu(
            data: marketsHeaderMenuItems,
            activeIndex: _activeIndex,
            onItemSelected: (ind) {
              print(ind);
              setState(() {
                _activeIndex = ind;
              });
            },
            scrollController: _scrollController,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _filteredMarkets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return VerticalListItem(listItemModel: _filteredMarkets[index]);
            },
          )
        ],
      ),
    );
  }
}
