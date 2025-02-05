import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SingleOrder extends StatefulWidget {
  String orderId;
  String preparingStatus;
  String arriveBetween;
  String address;
  // List products;

  SingleOrder(
      {super.key,
      required this.address,
      required this.arriveBetween,
      required this.orderId,
      required this.preparingStatus});

  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Row(
          children: [Text("Buyurtma "), Icon(Icons.tag), Text(widget.orderId)],
        ),
      ),
      body: SafeArea(
          child: Column(
        spacing: 16,
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
                  "Buyurtmangiz jarayonda",
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
                      color: Color(0x90ffffff),
                    )),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/delivery.svg",
                          color: Color(0xffff9556),
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
                          color: Color(0x20000000),
                          borderRadius: BorderRadius.circular(36)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: Color(0xffffffff),
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      style: TextStyle(color: Color(0xffff9556), fontSize: 20),
                    )
                  ],
                )),
          ),
          Divider(
            color: Color(0x203c486b),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Mahsulotlar (12)",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff3c486b),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ),
          singleProduct(context)
        ],
      )),
    );
  }

  Container singleProduct(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0x203c486b)),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://www.coca-cola.com/content/dam/onexp/us/en/brands/coca-cola-original/en_coca-cola-original-taste-20-oz_750x750_v1.jpg/width1960.jpg"))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Coca-cola",
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
                      child: Text("X2",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Text("1.5 L",
                    style: TextStyle(
                        color: Color(0x903c486b),
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Text("10 000 So`m",
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
