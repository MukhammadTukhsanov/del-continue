import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/firebase_database_service.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/home.dart';
import 'package:geo_scraper_mobile/presentation/utils/number_format.dart';
import 'package:geo_scraper_mobile/presentation/utils/remove_spaces_and_convert_to_int.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:geo_scraper_mobile/presentation/widgets/text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderPayment extends StatefulWidget {
  final String id;
  final bool isDeliveryFree;
  final String deliveryPrice;
  final List<dynamic> basket;
  final int totalPrice;
  final String maxDeliveryTime;

  const OrderPayment(
      {super.key,
      required this.id,
      required this.isDeliveryFree,
      required this.deliveryPrice,
      required this.basket,
      required this.totalPrice,
      required this.maxDeliveryTime});

  @override
  _OrderPaymentState createState() => _OrderPaymentState();
}

class _OrderPaymentState extends State<OrderPayment> {
  String street = "";
  String locality = "";
  String country = "";
  String region = "";

  bool isLoading = false;

  final TextEditingController _addresController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Map<String, dynamic>> user = [];

  @override
  void initState() {
    super.initState();
    _getAddress();
    _userInfo();
  }

  Future<void> _userInfo() async {
    List<Map<String, dynamic>> fetchedUser =
        await StorageService.getDataFromLocal(StorageType.userInfo);
    setState(() {
      user = fetchedUser;
    });
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

  Future<void> sendOrder(
      List<dynamic> data,
      String id,
      bool isDeliveryFree,
      String deliveryPrice,
      int totalPrice,
      String maxDeliveryTime,
      BuildContext context) async {
    FirebaseDatabaseService databaseService = FirebaseDatabaseService();

    try {
      setState(() {
        isLoading = true;
      });
      bool success = await databaseService.sendOrder(data, id, isDeliveryFree,
          deliveryPrice, totalPrice, user[0]["phoneNumber"], maxDeliveryTime);
      setState(() {
        isLoading = false;
      });

      if (success) {
        _showAlertDialog(
          context,
          "Buyurtmangiz qabul qilindi, tez orada yetkaziladi.",
          "Savdoga qaytish.",
          () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          },
        );
      } else {
        _showAlertDialog(
          context,
          "Buyurtmani yuborishda xatolik yuz berdi. Qayta urinib ko'ring.",
          "Ortga",
          () {
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      _showAlertDialog(
        context,
        "Buyurtmani yuborishda xatolik yuz berdi.}",
        "Ortga",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void _showAlertDialog(BuildContext context, String subtitle,
      String buttonTitle, VoidCallback onSubmit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {}
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: LoadingAnimationWidget.halfTriangleDot(
                color: Color(0xff3c486b), size: 50),
            content: SizedBox(
              height: 102,
              child: Column(
                spacing: 16,
                children: [
                  Text(
                    "Tayyor!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff3c486b),
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 18, color: Color(0xff3c486b)),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          WidgetStateProperty.all(const Size.fromHeight(51)),
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xffff9556)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                    ),
                    onPressed: onSubmit,
                    child: Text(
                      buttonTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        );
      },
    );
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
          surfaceTintColor: Colors.white,
          title: const Text("To`lov"),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: Column(children: [
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
                                      style:
                                          TextStyle(color: Color(0xff3c486b)),
                                    ),
                                    // Constrain width of CustomTextField
                                    CustomTextField(
                                      label: "Manzil",
                                      controller: _addresController,
                                      focusNode: _focusNode,
                                      maxLines: 1,
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
                                        color: const Color(0x203c486b),
                                        width: 1),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0x203c486b))),
                                      child: SvgPicture.asset(
                                        "assets/icons/click.svg",
                                        width: 80,
                                        height: 24,
                                      ))),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0x203c486b))),
                                      child: SvgPicture.asset(
                                        "assets/icons/payme.svg",
                                        width: 80,
                                        height: 24,
                                      ))),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0x203c486b))),
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
                                border: Border.all(
                                    width: 1, color: Color(0x203c486b)),
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
                          SizedBox(height: 20),
                          Column(
                            spacing: 16,
                            children: [
                              ...widget.basket.asMap().entries.map((entrie) {
                                var item = entrie.value;
                                int index = entrie.key;
                                return Row(
                                  children: [
                                    Text('${item["name"]}'),
                                    Expanded(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          int dotCount =
                                              (constraints.maxWidth / 6)
                                                  .floor();
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                dotCount, (index) => Text('.')),
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                        '${item['price']} X ${item['count']}${item['unitOfMeasure']} X ${formatNumber(removeSpacesAndConvertToInt(item['price']) * item['count'])}so`m'),
                                  ],
                                );
                              })
                            ],
                          )
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
                      (widget.isDeliveryFree)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Sizga bepul yetkazip beriladi.",
                                  style: TextStyle(
                                      color: Color(0xff3c486b),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          : Row(
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
                            "${formatNumber(widget.totalPrice + (widget.isDeliveryFree ? 0 : removeSpacesAndConvertToInt(widget.deliveryPrice)))} So`m",
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
                          child: CustomButton(
                            text: "Buyurtma berish",
                            onPressed: () {
                              sendOrder(
                                  widget.basket,
                                  widget.id,
                                  widget.isDeliveryFree,
                                  widget.deliveryPrice,
                                  widget.totalPrice,
                                  widget.maxDeliveryTime,
                                  context);
                            },
                          ))
                    ],
                  ),
                )
              ]),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3), // Dim background
                child: Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: Color(0xff3c486b), size: 50),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
