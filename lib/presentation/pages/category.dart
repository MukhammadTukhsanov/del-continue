import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/manual-address-selection-screen/index.dart';
import 'package:geo_scraper_mobile/presentation/pages/filtred_markets.dart';
import 'package:geo_scraper_mobile/presentation/state/category_header_menu_items.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  DateTime? lastBackPressed;

  List data = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));

      await _getAddress();
      await _loadData();
    } catch (e) {
      print('Error in initialize: $e');
      setState(() {
        errorMessage = 'Ma\'lumotlarni yuklashda xatolik: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      print('Loading data from storage...');

      // Load markets data
      List marketsData =
          await StorageService.getDataFromLocal(StorageType.markets);
      print('Markets data loaded: ${marketsData.length} items');

      // Load kitchens data
      List kitchensData =
          await StorageService.getDataFromLocal(StorageType.kitchens);
      print('Kitchens data loaded: ${kitchensData.length} items');

      // Combine data
      List combinedData = [...marketsData, ...kitchensData];
      print('Combined data: ${combinedData.length} items');

      setState(() {
        data = combinedData;
      });

      // Debug: Print first few items
      if (combinedData.isNotEmpty) {
        print('Sample data items:');
        for (int i = 0;
            i < (combinedData.length > 3 ? 3 : combinedData.length);
            i++) {
          print('Item $i: ${combinedData[i]}');
        }
      } else {
        print('WARNING: No data found in storage!');
        // Check if storage has any data at all
        await _checkStorageContents();
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        errorMessage = 'Ma\'lumotlarni yuklashda xatolik: $e';
        data = [];
      });
    }
  }

  Future<void> _checkStorageContents() async {
    try {
      print('Checking storage contents...');

      // Check what storage types are available
      final allStorageTypes = [
        StorageType.markets,
        StorageType.kitchens,
        // Add other storage types if needed
      ];

      for (final storageType in allStorageTypes) {
        try {
          final data = await StorageService.getDataFromLocal(storageType);
          print('Storage $storageType: ${data.length} items');
        } catch (e) {
          print('Error checking $storageType: $e');
        }
      }
    } catch (e) {
      print('Error checking storage: $e');
    }
  }

  Future<void> _getAddress() async {
    try {
      Map<String, String>? address = await StorageService.getSavedAddress();
      print('Address loaded: $address');

      setState(() {
        street = address?['street'] ?? "Manzil";
        locality = address?['locality'] ?? "tanlanmagan";
        country = address?['country'] ?? "";
        region = address?['region'] ?? "";
      });
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        street = "Manzil";
        locality = "tanlanmagan";
        country = "";
        region = "";
      });
    }
  }

  Future<void> _changeAddress() async {
    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapAddressSelectionScreen(),
        ),
      );

      if (result == true) {
        await _getAddress();

        // Reload data after address change if needed
        await _loadData();

        if (mounted) {
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
    } catch (e) {
      print('Error changing address: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Manzilni o\'zgartirishda xatolik: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget _buildDataSection() {
    if (isLoading) {
      return ShimmerLoaders.buildShimmerList(
        context,
        ShimmerLoadersItems.verticalListItemShimmer,
        count: 6,
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                initialize(); // Retry loading data
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff9556),
                foregroundColor: Colors.white,
              ),
              child: Text('Qayta urinish'),
            ),
          ],
        ),
      );
    }

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              color: Colors.grey,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'Hech qanday ma\'lumot topilmadi',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ma\'lumotlar yuklanishini kuting yoki ilovani qayta ishga tushiring',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     initialize(); // Retry loading data
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Color(0xffff9556),
            //     foregroundColor: Colors.white,
            //   ),
            //   child: Text('Yangilash'),
            // ),
          ],
        ),
      );
    }

    // Data is available, show the list
    final List<ListItemModel> displayedMarkets =
        data.map((map) => ListItemModel.fromMap(map)).toList()..shuffle();

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
  }

  // Add a method to manually refresh data
  Future<void> _refreshData() async {
    await initialize();
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

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$street $locality',
                style: const TextStyle(
                  color: Color(0xff3c486b),
                  fontSize: 19,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$region $country",
                style: const TextStyle(
                  color: Color(0xff3c486b),
                  fontSize: 16,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: _changeAddress,
              icon: SvgPicture.asset(
                "assets/icons/edit.svg",
                width: 28,
              ),
            ),
            // Add refresh button for debugging
            IconButton(
              onPressed: _refreshData,
              icon: Icon(Icons.refresh),
              tooltip: 'Ma\'lumotlarni yangilash',
            ),
          ],
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: const Color(0xffd8dae1),
              height: 1,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header section
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffd8dae1)),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categoryHeaderMenuItems
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              final filteredData = data
                                  .where((market) => market["type"] == e["id"])
                                  .toList();

                              print(
                                  'Filtering for ${e["id"]}: ${filteredData.length} items');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FiltredMarkets(
                                    title: e["title"] ?? "",
                                    data: filteredData,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 85),
                                  width: 85,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(e["image"] ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  e["title"] ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff3c486b),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              // Main content section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Barchasi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff3c486b),
                              ),
                            ),
                            if (!isLoading && data.isNotEmpty)
                              Text(
                                '${data.length} ta element',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                      _buildDataSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Keep your existing methods (_onWillPop, _showExitDialog) unchanged
}
