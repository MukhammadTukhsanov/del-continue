import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/pages/single-order.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

const List<Map<String, String>> ordersList = [
  {
    "orderId": "5252",
    "orderDate": "24 May 2024 - 11:30",
    "orderStatus": "pending",
    "orderPrice": "100 000"
  },
  {
    "orderId": "5252",
    "orderDate": "24 May 2024 - 11:30",
    "orderStatus": "successful",
    "orderPrice": "100 000"
  },
  {
    "orderId": "5252",
    "orderDate": "24 May 2024 - 11:30",
    "orderStatus": "canceled",
    "orderPrice": "100 000"
  },
];

class _OrdersState extends State<Orders> {
  final List<bool> _selectedFruits = <bool>[true, false];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(0x103c486b)),
              child: ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedFruits.length; i++) {
                      _selectedFruits[i] = i == index;
                    }
                  });
                },
                renderBorder: false,
                selectedColor: Color(0xff3c486b),
                fillColor: Colors.transparent,
                splashColor: Colors.transparent,
                color: Color(0x803c486b),
                constraints:
                    const BoxConstraints(minHeight: 40.0, minWidth: 160.0),
                isSelected: _selectedFruits,
                children: [
                  Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          color: _selectedFruits[0]
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(child: Text('Faol buyurtmalar'))),
                  Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                          color: _selectedFruits[1]
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(child: Text('Buyurtmalar tarixi'))),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          if (ordersList.isEmpty)
            Expanded(
                child: Center(
                    child: SizedBox(
              height: 261,
              child: Column(children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color(0x103c486b),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: SvgPicture.asset("assets/icons/bag-02.svg"))),
                SizedBox(height: 10),
                Text(
                  "Xozircha bu yer bo`sh!",
                  style: TextStyle(
                      color: Color(0xff3c486b),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: 220,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Iltimos buyurtma berush uchun, kategoriyaga o`ting",
                    style: TextStyle(color: Color(0x903c486b), fontSize: 14),
                  ),
                ),
                SizedBox(height: 10),
                CustomButton(text: "Xarid qilishga o`ting", onPressed: () {})
              ]),
            )))
          else if (_selectedFruits[0])
            ...ordersList
                .where((order) => order["orderStatus"] == "pending")
                .map((order) => orderItem(
                        order["orderId"]!,
                        order["orderDate"]!,
                        order["orderStatus"]!,
                        order["orderPrice"]!, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleOrder(
                                  address:
                                      "O`zbekiston ko`chasi, Peshku, Buxoro",
                                  arriveBetween: "12:23 - 13:20",
                                  orderId: order["orderId"]!,
                                  preparingStatus: "inPlace")));
                    }))
          else if (_selectedFruits[1])
            ...ordersList.map((item) => orderItem(
                    item["orderId"]!,
                    item["orderDate"]!,
                    item["orderStatus"]!,
                    item["orderPrice"]!, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleOrder(
                              address: "O`zbekiston ko`chasi, Peshku, Buxoro",
                              arriveBetween: "12:23 - 13:20",
                              orderId: item["orderId"]!,
                              preparingStatus: "inPlace")));
                })),
        ],
      )),
    );
  }

  GestureDetector orderItem(String orderNum, String date, String status,
      String orderPrise, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0x203c486b)))),
        child: Row(children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buyurtma",
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  SizedBox(width: 6),
                  Icon(Icons.tag, color: Color(0xff3c486b), size: 20),
                  Text(orderNum,
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                          color: status == "successful"
                              ? Colors.green
                              : status == "pending"
                                  ? Color(0xffff9556)
                                  : Colors.red[800],
                          borderRadius: BorderRadius.circular(8))),
                  Text(
                    status == "successful"
                        ? "Buyurtma qabul qilingan."
                        : status == "pending"
                            ? "Yetkazilmoqda."
                            : "Bekor bo`lgan.",
                    style: TextStyle(
                        color: Color(0x903c486b), fontWeight: FontWeight.w600),
                  )
                ],
              )
            ]),
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.watch_later_outlined,
                          color: Color(0x903c486b), size: 16),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(
                            color: Color(0x903c486b),
                            fontWeight: FontWeight.w600),
                      )
                    ]),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: orderPrise,
                      style: TextStyle(
                          color: Color(0xff3c486b),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                  TextSpan(text: " So`m")
                ]))
              ]))
        ]),
      ),
    );
  }
}
