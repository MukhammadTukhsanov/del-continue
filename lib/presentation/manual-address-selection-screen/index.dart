import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/services/geocoding_service.dart';
import 'package:latlong2/latlong.dart';

class MapAddressSelectionScreen extends StatefulWidget {
  const MapAddressSelectionScreen({super.key});

  @override
  _MapAddressSelectionScreenState createState() =>
      _MapAddressSelectionScreenState();
}

class _MapAddressSelectionScreenState extends State<MapAddressSelectionScreen> {
  final MapController _mapController = MapController();

  static const LatLng _peshkuCenter = LatLng(40.041686, 64.396957);
  static const LatLng _yangibozorCenter = LatLng(40.041686, 64.396957);

  var currentLocation;

  LatLng _selectedLocation = _peshkuCenter;
  String _selectedAddress = "Buxoro, Peshku Yangibozor";
  bool _isLoading = false;

  final List<Map<String, dynamic>> _predefinedLocations = [
    {'name': 'Peshku', 'location': _peshkuCenter, 'address': 'Peshku tumani'},
    {
      'name': 'Yangibozor',
      'location': _yangibozorCenter,
      'address': 'Yangibozor ko\'chasi'
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      var currentLocation = await StorageService.getUserLocation();

      // Check if location exists and has valid coordinates
      if (currentLocation != null &&
          currentLocation["latitude"] != null &&
          currentLocation["longitude"] != null) {
        // Location found - update the selected location
        setState(() {
          _selectedLocation = LatLng(currentLocation["latitude"]!.toDouble(),
              currentLocation["longitude"]!.toDouble());
        });

        // Move map to current location
        _mapController.move(_selectedLocation, 14.0);

        // Get address for this location
        await _getAddressFromCoordinates(_selectedLocation);
      } else {
        // No location found in storage
        print('No saved location found');
        // Optionally show a message to user or request location permission
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Saqlangan manzil topilmadi'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      print('Error getting current location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Manzilni olishda xatolik: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xffff9556),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Manzilni tanlang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _selectedLocation,
                    initialZoom: 12.0,
                    minZoom: 10.0,
                    maxZoom: 18.0,
                    onTap: (tapPosition, point) {
                      _onMapTap(point);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.geo_scraper_mobile',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _selectedLocation,
                          child: const Icon(
                            Icons.location_pin,
                            color: Color(0xffff9556),
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Address Info Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xffff9556),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Tanlangan manzil:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222B45),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedAddress,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8F9BB3),
                  ),
                ),
              ],
            ),
          ),

          // Confirm Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _confirmLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffff9556),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Manzilni tasdiqlash',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _selectedLocation = point;
      _selectedAddress = "Lat: ${point.latitude.toStringAsFixed(4)}, "
          "Lng: ${point.longitude.toStringAsFixed(4)}";
    });

    // Get address from coordinates
    _getAddressFromCoordinates(point);
  }

  void _selectPredefinedLocation(Map<String, dynamic> location) {
    setState(() {
      _selectedLocation = location['location'];
      _selectedAddress = location['address'];
    });

    _mapController.move(_selectedLocation, 14.0);
  }

  Future<void> _getAddressFromCoordinates(LatLng point) async {
    try {
      final address = await GeocodingService.getAddressFromCoordinates(
        point.latitude,
        point.longitude,
      );

      if (mounted) {
        setState(() {
          _selectedAddress = "${address['street'] ?? 'Unknown'}, "
              "${address['locality'] ?? 'Unknown'}";
        });
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  Future<void> _confirmLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Save location to storage
      await StorageService.saveUserLocation(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );

      // Get full address details
      final address = await GeocodingService.getAddressFromCoordinates(
        _selectedLocation.latitude,
        _selectedLocation.longitude,
      );

      // Save address to storage
      await StorageService.saveAddress(
        address['street'] ?? 'Unknown Street',
        address['locality'] ?? 'Buxoro',
        address['country'] ?? "O'zbekiston",
        address['region'] ?? 'Buxoro viloyati',
      );

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Manzil muvaffaqiyatli saqlandi!'),
            backgroundColor: Color(0xffff9556),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Return to previous screen
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xatolik: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
