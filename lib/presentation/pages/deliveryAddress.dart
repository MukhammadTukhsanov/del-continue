import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
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
  int? selectedIndex = 0;

  bool addNewAddress = false;

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
            addNewAddress ? 'Yangi manzil qo`shish' : 'Mening manzillarim',
            style: TextStyle(
              color: Color(0xff3c486b),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          addNewAddress
              ? Expanded(child: AddNewAddress())
              : Expanded(
                  child: ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex =
                                  null; // Uncheck if already selected
                            } else {
                              selectedIndex = index; // Select new item
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 4,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Color(0xffff9556)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4))),
                            Expanded(
                              child: ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/icons/marker.svg",
                                    color: Color(0xffff9556),
                                  ),
                                  title: Text(
                                    addresses[index]["title"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff3c486b),
                                    ),
                                  ),
                                  subtitle: Text(
                                    addresses[index]["address"]!,
                                    style: TextStyle(color: Color(0x903c486b)),
                                  )),
                            ),
                            IconButton(
                                color: Color(0x903c486b),
                                onPressed: () {},
                                icon: Icon(Icons.edit_location_outlined)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(
            width: double.infinity,
            child: addNewAddress
                ? Row(children: [
                    Expanded(
                        child: CustomButton(
                            text: "Joyni tanlash", onPressed: () {})),
                    SizedBox(width: 10),
                    SizedBox(
                        child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize:
                            WidgetStateProperty.all(const Size.fromHeight(51)),
                        backgroundColor:
                            const WidgetStatePropertyAll(Color(0xfff8f8fa)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                      onPressed: () {
                        setState(() {
                          addNewAddress = false;
                        });
                      },
                      child: const Text(
                        "Ortga",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff898e96),
                        ),
                      ),
                    ))
                  ])
                : TextButton(
                    onPressed: () {
                      setState(() {
                        addNewAddress = true;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Color(0xffff9556),
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Yangi manzil qo`shish",
                          style:
                              TextStyle(color: Color(0xffff9556), fontSize: 18),
                        )
                      ],
                    )),
          )
        ],
      ),
    );
  }
}

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Manzil",
          textAlign: TextAlign.start,
          style: TextStyle(color: Color(0xff3c486b)),
        ),
        CustomTextField(
          label: "Manzil",
          controller: _addressController,
          // focusNode: _focusNode,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text(
                    "Xonadon",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color(0xff3c486b)),
                  ),
                  CustomTextField(
                    label: "02",
                    controller: _addressController,
                    // focusNode: _focusNode,
                  )
                ])),
            SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text(
                    "Podyezd",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color(0xff3c486b)),
                  ),
                  CustomTextField(
                    label: "12",
                    controller: _addressController,
                    // focusNode: _focusNode,
                  )
                ])),
            SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Text(
                    "Uy",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color(0xff3c486b)),
                  ),
                  CustomTextField(
                    label: "8",
                    controller: _addressController,
                    // focusNode: _focusNode,
                  )
                ]))
          ],
        ),
        SizedBox(height: 24),
        const Text(
          "Izohlar",
          textAlign: TextAlign.start,
          style: TextStyle(color: Color(0xff3c486b)),
        ),
        CustomTextField(
          label: "8",
          controller: _addressController,
          maxLines: 5,
          // focusNode: _focusNode,
        )
      ],
    );
  }
}
