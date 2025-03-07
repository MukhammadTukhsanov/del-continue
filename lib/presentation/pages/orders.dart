import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/core/services/firebase_database_service.dart';
import 'package:geo_scraper_mobile/presentation/pages/home.dart';
import 'package:geo_scraper_mobile/presentation/pages/single-order.dart';
import 'package:geo_scraper_mobile/presentation/utils/number_format.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';
import 'package:intl/intl.dart';

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
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    _getOrdersLit();
  }

  Future<void> _getOrdersLit() async {
    FirebaseDatabaseService databaseService = FirebaseDatabaseService();

    List<Map<String, dynamic>>? orders =
        await databaseService.fetchOrdersList();

    setState(() {
      data = orders!;
    });
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
                CustomButton(
                    text: "Xarid qilishga o`ting",
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Home()));
                    })
              ]),
            )))
          else if (_selectedFruits[0])
            ...data
                .where((order) =>
                    order["orderStatus"] == "preparing" ||
                    order["orderStatus"] == "onRoad")
                .map((order) => orderItem(
                        order["id"]!,
                        DateFormat("dd MMM yyyy - HH:mm")
                            .format(order["createdAt"].toDate()),
                        order["orderStatus"]!,
                        formatNumber(order["totalPrice"]), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleOrder(
                                  date: DateFormat("dd MMM yyyy - HH:mm")
                                      .format(order["createdAt"].toDate()),
                                  address:
                                      "O`zbekiston ko`chasi, Peshku, Buxoro",
                                  arriveBetween:
                                      DateFormat("dd MMM yyyy - HH:mm")
                                          .format(order["createdAt"].toDate()),
                                  orderId: order["id"]!,
                                  preparingStatus: order["orderStatus"],
                                  products: order["items"])));
                    }))
          else if (_selectedFruits[1])
            ...data.map((item) => orderItem(
                    item["id"]!,
                    DateFormat("dd MMM yyyy - HH:mm")
                        .format(item["createdAt"].toDate()),
                    item["orderStatus"]!,
                    formatNumber(item["totalPrice"]), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleOrder(
                              date: DateFormat("dd MMM yyyy - HH:mm")
                                  .format(item["createdAt"].toDate()),
                              address: "O`zbekiston ko`chasi, Peshku, Buxoro",
                              arriveBetween: DateFormat("dd MMM yyyy - HH:mm")
                                  .format(item["createdAt"].toDate()),
                              orderId: item["id"]!,
                              preparingStatus: "inPlace",
                              products: item["items"])));
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
                              : status == "preparing" || status == "onRoad"
                                  ? Color(0xffff9556)
                                  : Colors.red[800],
                          borderRadius: BorderRadius.circular(8))),
                  Text(
                    status == "successful"
                        ? "Buyurtma qabul qilingan."
                        : status == "preparing" || status == "onRoad"
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
