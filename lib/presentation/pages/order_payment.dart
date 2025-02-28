import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:location/location.dart';

class OrderPayment extends StatefulWidget {
  final String id;
  final List<dynamic> basket;
  final int totalPrice;
  const OrderPayment(
      {super.key,
      required this.id,
      required this.basket,
      required this.totalPrice});

  @override
  _OrderPaymentState createState() => _OrderPaymentState();
}

class _OrderPaymentState extends State<OrderPayment> {
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  final TextEditingController _addresController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    Map<String, String>? address = await StorageService.getSavedAddress();

    setState(() {
      street = address['street'] ?? "";
      locality = address['locality'] ?? "";
      country = address['country'] ?? "";
      region = address['region'] ?? "";

      _addresController.text = "$street, $locality, $region, $country";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("To`lov"),
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Yetkazib berish manzili: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Color(0xff3c486b)),
                              ),
                              // Constrain width of CustomTextField
                              CustomTextField(
                                label: "Manzil",
                                controller: _addresController,
                                focusNode: _focusNode,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0x203c486b), width: 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const MapScreen()));
                              },
                              icon: const Icon(Icons.map_outlined)),
                        )
                      ],
                    ),
                    SizedBox(height: 35),
                    const Text(
                      "To`lov tizimini tanlang: ",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Color(0xff3c486b)),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Color(0x203c486b))),
                                child: SvgPicture.asset(
                                  "assets/icons/click.svg",
                                  width: 80,
                                  height: 24,
                                ))),
                        SizedBox(width: 10),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Color(0x203c486b))),
                                child: SvgPicture.asset(
                                  "assets/icons/payme.svg",
                                  width: 80,
                                  height: 24,
                                ))),
                        SizedBox(width: 10),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Color(0x203c486b))),
                                child: SvgPicture.asset(
                                  "assets/icons/apelsin.svg",
                                  width: 80,
                                  height: 24,
                                ))),
                      ],
                    ),
                    SizedBox(height: 35),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Color(0x203c486b)),
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Color(0xffff9556),
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            "Diqqat! Siz buyurtma berish orqali shartlarga rozi ekanligingizni bildirasiz.",
                            style: TextStyle(
                                color: Color(0xff3c486b), fontSize: 16),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Color(0x203c486b)))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yetkazib berish",
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text("10 000 So`m",
                        style: TextStyle(
                            color: Color(0xff3c486b),
                            fontSize: 16,
                            fontWeight: FontWeight.w600))
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Umumiy summa",
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "110 000 So`m",
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    child:
                        CustomButton(text: "Buyurtma berish", onPressed: () {}))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
