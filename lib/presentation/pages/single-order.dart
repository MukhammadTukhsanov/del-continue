import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/widgets/shimmer_loaders.dart';
import 'package:intl/intl.dart';

class SingleOrder extends StatefulWidget {
  String date;
  String orderId;
  String preparingStatus;
  String arriveBetween;
  String address;
  List products;

  SingleOrder(
      {super.key,
      required this.date,
      required this.address,
      required this.arriveBetween,
      required this.orderId,
      required this.preparingStatus,
      required this.products});

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  void initState() {
    super.initState();
    print("products: ${widget.products}");
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
        title: Row(
          children: [Text("Buyurtma "), Icon(Icons.tag), Text(widget.orderId)],
        ),
      ),
      body: SafeArea(
          child: Column(
        // spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xffff9556),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.preparingStatus == "preparing"
                      ? "Tayyorlanmoqda"
                      : widget.preparingStatus == "onRoad"
                          ? "Yo`lda"
                          : "Bekor qilingan.",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Text.rich(TextSpan(
                    children: [
                      TextSpan(text: widget.arriveBetween),
                      TextSpan(
                          text: " vaqt oralig`ida yetkaziladi.",
                          style: TextStyle(color: Color(0x99ffffff)))
                    ],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16))),
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/turkey.svg",
                          color: Color(0xffff9556),
                          width: 26,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 4,
                      color: widget.preparingStatus == "onRoad" ||
                              widget.preparingStatus == "successful"
                          ? Color(0x90ffffff)
                          : Color(0x20000000),
                    )),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: widget.preparingStatus == "onRoad" ||
                                  widget.preparingStatus == "successful"
                              ? Colors.white
                              : Color(0x20000000),
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/delivery.svg",
                          color: widget.preparingStatus == "onRoad" ||
                                  widget.preparingStatus == "successful"
                              ? Color(0xffff9556)
                              : Colors.white,
                          width: 26,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 4,
                      color: Color(0x20000000),
                    )),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: widget.preparingStatus == "successful"
                              ? Colors.white
                              : Color(0x20000000),
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: widget.preparingStatus == "successful"
                              ? Color(0xffff9556)
                              : Color(0xffffffff),
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffD8DAE1)))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size.fromHeight(51)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xffff9556)),
                          borderRadius: BorderRadius.circular(10))),
                      elevation: WidgetStatePropertyAll(0),
                      backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/googleMaps.svg",
                          color: Color(0xffff9556), width: 30),
                      Text(
                        "Xaritada kuzatish",
                        style:
                            TextStyle(color: Color(0xffff9556), fontSize: 20),
                      )
                    ],
                  )),
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Color(0x203c486b),
            height: 1,
            endIndent: 0,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(
                    "Mahsulotlar (${widget.products.length})",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xff3c486b),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: 16),
                ...[
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products,
                  ...widget.products
                ].asMap().entries.map((e) {
                  var item = e.value;
                  int index = e.key;
                  return singleProduct(
                      context,
                      item["photo"],
                      item["name"],
                      item["measurementValue"],
                      item["unitOfMeasure"],
                      item["price"],
                      item["count"]);
                })
              ],
            ),
          )),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Color(0xffd8dae1)))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
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
                    "12 000 So`m",
                    style: TextStyle(
                        color: Color(0xff3c486b),
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Container singleProduct(BuildContext context, String photo, String name,
      String measurementValue, String unitOfMeasure, String price, int count) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 10,
        children: [
          ShimmerLoaders.imageWithShimmer(context, photo, 100, 100),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Color(0xff3c486b),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0x203c486b)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("X$count",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Text("$measurementValue $unitOfMeasure",
                    style: TextStyle(
                        color: Color(0x903c486b),
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Text("$price So`m",
                    style: TextStyle(
                        color: Color(0xff3c486b),
                        fontSize: 16,
                        fontWeight: FontWeight.w700))
              ],
            ),
          )
        ],
      ),
    );
  }
}
