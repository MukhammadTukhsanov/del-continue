import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  GoogleMapController? _controller;
  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 20,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var currentLocation = await StorageService.getUserLocation();

    if (currentLocation != null &&
        currentLocation["latitude"] != null &&
        currentLocation["longitude"] != null) {
      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(
            currentLocation["latitude"]!,
            currentLocation["longitude"]!,
          ),
          zoom: 15,
        );
      });

      if (_controller != null) {
        _controller!
            .animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller
        ?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialPosition,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () {
                      _controller?.animateCamera(
                        CameraUpdate.newLatLng(_initialPosition.target),
                      );
                    },
                    backgroundColor: Colors.white,
                    child: Icon(Icons.my_location, color: Colors.black),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor:
                            WidgetStatePropertyAll(Color(0xffff9556)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return BottomSheetWidget();
                          },
                        );
                      },
                      child: Text(
                        'Mening manzillarim',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<Map<String, String>> addresses = [
    {"title": "Home", "address": "Peshko`, O`zbekiston ko`cha"},
    {"title": "Uy", "address": "Peshko`, Amir temur ko`cha"},
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      height: MediaQuery.of(context).size.height * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mening manzillarim',
            style: TextStyle(
              color: Color(0xff3c486b),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        decoration: BoxDecoration(color: Color(0xffff9556)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            left: selectedIndex == index
                                ? BorderSide(color: Colors.blue, width: 4)
                                : BorderSide.none,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          addresses[index]["title"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff3c486b),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
