import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/coming-soon/index.dart';
import 'package:geo_scraper_mobile/presentation/manual-address-selection-screen/index.dart';
import 'package:geo_scraper_mobile/presentation/pages/all_items.dart';
import 'package:geo_scraper_mobile/presentation/pages/discounts.dart';
import 'package:geo_scraper_mobile/presentation/widgets/horizontal_list_item.dart';
import 'package:geo_scraper_mobile/presentation/widgets/list_title.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

List<Map<String, dynamic>> menuItems = [
  {
    "title": "Chegirmalar",
    "imagePath": "./assets/images/persent.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Discounts()));
    }
  },
  {
    "title": "Savdo",
    "imagePath": "./assets/images/moreSales.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AllItems()));
    }
  },
  {
    "title": "Kuponlarim",
    "imagePath": "./assets/images/coupon.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ComingSoonScreen(
                    title: '',
                  )));
    }
  },
  {
    "title": "Kel ol",
    "imagePath": "./assets/images/delive.png",
    "onTap": (BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ComingSoonScreen(
                    title: '',
                  )));
    }
  },
];

class _MainState extends State<Main> {
  String street = "Ko`cha aniqlanmadi";
  String locality = "";
  String country = "";
  String region = "";
  DateTime? lastBackPressed;

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();
    setState(() {
      street = address['street'] ?? street;
      locality = address['locality'] ?? locality;
      country = address['country'] ?? country;
      region = address['region'] ?? region;
    });
  }

  Future<void> _changeAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapAddressSelectionScreen(),
      ),
    );

    if (result == true) {
      _getAddress();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Manzil yangilandi!'),
          backgroundColor: Color(0xffff9556),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    const maxDuration = Duration(seconds: 2);
    final isWarning = lastBackPressed == null ||
        now.difference(lastBackPressed!) > maxDuration;

    if (isWarning) {
      lastBackPressed = DateTime.now();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ilovadan chiqish uchun qaytadan "orqaga" tugmasini bosing',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xffff9556),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool> _showExitDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Ilovadan chiqish',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222B45),
                ),
              ),
              content: Text(
                'Rostdan ham ilovadan chiqmoqchimisiz?',
                style: TextStyle(
                  color: Color(0xFF8F9BB3),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Yo\'q',
                    style: TextStyle(
                      color: Color(0xFF8F9BB3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff9556),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Ha',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _onWillPop();
        if (shouldExit && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffff9556),
        body: SafeArea(
          child: RefreshIndicator(
            color: const Color(0xffff9556),
            onRefresh: () async {
              await _getAddress();
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            notificationPredicate: (notification) => notification.depth == 1,
            child: SingleChildScrollView(
              child: Column(
                spacing: 4,
                children: [
                  _address(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomTextField(
                      label: "Ovqatlar, Mahsulotlar",
                      prefixIcon: Icons.search_rounded,
                    ),
                  ),
                  _buildContentContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _address() {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/icons/marker.svg",
        color: Colors.white,
        width: 26,
      ),
      title: Text("$street, $locality",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700)),
      subtitle: Text(
        "$region, $country",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
      trailing: GestureDetector(
        onTap: _changeAddress,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.edit_location_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildContentContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: menuItems.asMap().entries.map((entry) {
                var value = entry.value;
                return GestureDetector(
                  onTap: () => value['onTap'](context),
                  child: SizedBox(
                    key: ValueKey(value['title']),
                    width: MediaQuery.of(context).size.width / 4 - 8,
                    child: Center(
                      child: Column(
                        spacing: 3,
                        children: [
                          Image.asset(
                            value['imagePath']!,
                            width: 70,
                            height: 64,
                          ),
                          Text(
                            value['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color.fromARGB(204, 60, 72, 107),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(thickness: 1, color: Color(0x203c486b), height: 16),
          ListTitle(title: "Mashxur do'konlar", icon: false),
          _buildFamousMarketsList(),
          const SizedBox(height: 16),
          ListTitle(title: "Do`konlar", type: ListTitleTyps.markets),
          _buildMarketsList(),
          const SizedBox(height: 16),
          ListTitle(title: "Oshxonalar", type: ListTitleTyps.kitchens),
          _buildKitchenList(),
        ],
      ),
    );
  }

  Widget _buildFamousMarketsList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: StorageService.getDataFromLocal(StorageType.markets),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoaders.buildShimmerList(
              context, ShimmerLoadersItems.horizontalListItemShimmer);
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Нет данных"));
        }
        final List<ListItemModel> displayedMarkets = snapshot.data!
            .take(3)
            .map((map) => ListItemModel.fromMap(map))
            .toList();

        return SizedBox(
          height: 243,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: displayedMarkets.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return HorizontalListItem(listItemModel: displayedMarkets[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildKitchenList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: StorageService.getDataFromLocal(StorageType.kitchens),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoaders.buildShimmerList(
              context, ShimmerLoadersItems.verticalListItemShimmer);
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Нет данных"));
        }

        final List<ListItemModel> displayedMarkets =
            snapshot.data!.map((map) => ListItemModel.fromMap(map)).toList();
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(bottom: 12),
          itemCount: displayedMarkets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return VerticalListItem(listItemModel: displayedMarkets[index]);
          },
        );
      },
    );
  }

  Widget _buildMarketsList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: StorageService.getDataFromLocal(StorageType.markets),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerLoaders.buildShimmerList(
              context, ShimmerLoadersItems.verticalListItemShimmer);
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Нет данных"));
        }

        final List<ListItemModel> displayedMarkets =
            snapshot.data!.map((map) => ListItemModel.fromMap(map)).toList();
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(bottom: 12),
          itemCount: displayedMarkets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return VerticalListItem(listItemModel: displayedMarkets[index]);
          },
        );
      },
    );
  }
}
