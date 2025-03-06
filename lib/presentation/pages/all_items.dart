import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/state/markets_header_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/header_slider_menu.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontal_list_item.dart';
import 'package:geo_scraper_mobile/presentation/widgets/list_title.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

enum AllItemsType { kitchens, markets }

class AllItems extends StatefulWidget {
  final AllItemsType? type;
  const AllItems({super.key, this.type});

  @override
  _AllItemsState createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    if (widget.type == AllItemsType.kitchens) {
      await _getKitchens();
    } else {
      await _getMarkets();
    }
    await _getAddress();
  }

  List<ListItemModel> _markets = [];
  List<ListItemModel> _filteredMarkets = [];

  Future<void> _getMarkets() async {
    final data = await StorageService.getDataFromLocal(StorageType.markets);

    setState(() {
      _markets = data.map((map) {
        return ListItemModel.fromMap(map);
      }).toList();
      _filteredMarkets = _markets;
    });
  }

  Future<void> _getKitchens() async {
    final data = await StorageService.getDataFromLocal(StorageType.kitchens);

    setState(() {
      _markets = data.map((map) {
        return ListItemModel.fromMap(map);
      }).toList();
      _filteredMarkets = _markets;
    });
  }

  _handleFilterChange(int id) {
    if (_activeIndex == id) return;

    setState(() {
      _activeIndex = id;
      _filteredMarkets = marketsHeaderMenuItems[id]["id"] == "all"
          ? _markets
          : _markets
              .where((map) => map.type == marketsHeaderMenuItems[id]["id"])
              .toList();
    });
  }

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
          surfaceTintColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ListTitle(
                title:
                    "Mashhur ${widget.type == AllItemsType.kitchens ? "oshxonalar" : "do`konlar"}",
                icon: false),
            SizedBox(
              height: 243,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _markets.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return HorizontalListItem(listItemModel: _markets[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Color(0xffd8dae1), height: 1),
            const SizedBox(height: 10),
            Visibility(
                visible: widget.type != AllItemsType.kitchens,
                child: HeaderSliderMenu(
                  data: marketsHeaderMenuItems,
                  activeIndex: _activeIndex,
                  onItemSelected: _handleFilterChange,
                )),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _filteredMarkets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return VerticalListItem(listItemModel: _filteredMarkets[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
