import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/pages/order_payment.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';

class Basket extends StatefulWidget {
  final List<dynamic> basketData;
  const Basket({super.key, required this.basketData});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  final String _sumOfbasket = '12 000';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(1), // Set the height of the border
            child: Container(
              color: const Color(0xffd8dae1), // Border color
              height: 1, // Border height
            ),
          ),
          elevation: 0,
          title: const Text('Savat',
              style: TextStyle(
                  color: Color(0xff3c486b), fontFamily: 'Josefin Sans')),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context, widget.basketData); // Return updated basketData
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _showAlertDialog(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.delete_outlined),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const Expanded(
                child: Column(
              children: [
                BasketItem(),
                BasketItem(),
              ],
            )),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x203c486b))),
              child: Column(
                children: [
                  const Text(
                    "Jami:",
                    style: TextStyle(fontSize: 24, color: Color(0xff3c486b)),
                  ),
                  const Text(
                    "430 000 So`m",
                    style: TextStyle(fontSize: 36, color: Color(0xff3c486b)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    child: CustomButton(
                      text: "Buyurtma berish",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderPayment()));
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Icon(
            Icons.warning_amber_rounded,
            size: 96,
            color: Color(0xff3c486b),
          ),
          content: const SizedBox(
            height: 102,
            child: Column(
              spacing: 16,
              children: [
                Text(
                  "Diqqat!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff3c486b),
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
                Text(
                  "Haqiqatdanham barcha ma`lumotlarni o`chirmoqchimisiz.",
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
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text(
                    "Bekor qilish",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffffffff),
                    ),
                  ),
                )),
                Expanded(
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
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text(
                    "O`chirish",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff898e96),
                    ),
                  ),
                )),
              ],
            ),
          ],
        );
      },
    );
  }
}

class BasketItem extends StatelessWidget {
  const BasketItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0x203c486b)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0x203c486b)),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://www.coca-cola.com/content/dam/onexp/us/en/brands/coca-cola-original/en_coca-cola-original-taste-20-oz_750x750_v1.jpg/width1960.jpg"))),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Coca cola gazlangan",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.close))
                  ],
                ),
                const Text(
                  "1,5 L",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0x803c486b),
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0x203c486b)),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: Center(
                              child: IconButton(
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                        const EdgeInsets.all(4)), // Add padding
                                  ),
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove,
                                      color: Color(0xff3c486b))),
                            ),
                          ),
                          const SizedBox(
                              width: 24,
                              child: Center(
                                child: Text("12",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff3c486b))),
                              )),
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: IconButton(
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.all(4)), // Add padding
                                ),
                                onPressed: () {},
                                icon: const Icon(Icons.add,
                                    color: Color(0xff3c486b))),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "7 000 So`m",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
