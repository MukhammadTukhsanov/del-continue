import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/pages/order_payment.dart';
import 'package:geo_scraper_mobile/presentation/utils/number_format.dart';
import 'package:geo_scraper_mobile/presentation/utils/remove_spaces_and_convert_to_int.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';

class Basket extends StatefulWidget {
  final int totalPrice;
  final List data;
  final String id;
  final String deliveryPrice;
  final String afterFree;
  final bool isDeliveryFree;
  final String maxDeliveryTime;
  const Basket(
      {super.key,
      required this.totalPrice,
      required this.data,
      required this.id,
      required this.deliveryPrice,
      required this.afterFree,
      required this.isDeliveryFree,
      required this.maxDeliveryTime});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List<dynamic> products = [];
  bool isDeliveryFree = false;

  @override
  void initState() {
    super.initState();
    products = widget.data.map((product) => product.toJson()).toList();
    isDeliveryFree = widget.isDeliveryFree;
  }

  int get totalPrice => products.fold(
      0,
      (sum, item) =>
          sum +
          (removeSpacesAndConvertToInt(item["price"])) *
              (item["count"] as int));

  void clearBasket() {
    _showAlertDialog(
        context, "Haqiqatdanham barcha ma`lumotlarni o`chirmoqchimisiz.", () {
      setState(() {
        products.clear();
      });
      Navigator.of(context).pop();
    });
    checkIsDeliveryFree();
  }

  void checkIsDeliveryFree() {
    if (totalPrice >= removeSpacesAndConvertToInt(widget.afterFree)) {
      setState(() {
        isDeliveryFree = true;
      });
    } else {
      setState(() {
        isDeliveryFree = false;
      });
    }
  }

  void removeProduct(int index) {
    _showAlertDialog(
        context, "Haqiqatdanham ushbu ma`lumotni o`chirmoqchimisiz.", () {
      setState(() {
        products.removeAt(index);
      });
      Navigator.of(context).pop();
    });
    checkIsDeliveryFree();
  }

  void onAddProductCount(index) {
    setState(() {
      products[index]["count"]++;
    });
    checkIsDeliveryFree();
  }

  void onRemoveProductCount(index) {
    if (products[index]["count"] == 1) return removeProduct(index);
    setState(() {
      products[index]["count"]--;
    });
    checkIsDeliveryFree();
  }

  void goBackToProducts(BuildContext context) {
    Navigator.pop(context, {
      'updatedProducts': products,
      'newtotalPrice': totalPrice,
      'isDeliveryFree': isDeliveryFree
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          goBackToProducts(context);
        }
      },
      child: Scaffold(
          backgroundColor: const Color(0xffffffff),
          appBar: AppBar(
            backgroundColor: const Color(0xffffffff),
            surfaceTintColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color(0xffd8dae1),
                height: 1,
              ),
            ),
            elevation: 0,
            title: const Text('Savat',
                style: TextStyle(
                    color: Color(0xff3c486b), fontFamily: 'Josefin Sans')),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => goBackToProducts(context),
            ),
            actions: [
              GestureDetector(
                onTap: clearBasket,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.delete_outlined),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...products.asMap().entries.map((e) {
                      var item = e.value;
                      int index = e.key;

                      return BasketItem(
                          name: item["name"],
                          count: item["count"],
                          measurementValue: item["measurementValue"],
                          unitOfMeasure: item["unitOfMeasure"],
                          price: item["price"],
                          photo: item["photo"],
                          onAdd: () => onAddProductCount(index),
                          onRemove: () => onRemoveProductCount(index),
                          onDelete: () => removeProduct(index));
                    })
                  ],
                ),
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x203c486b))),
                child: Column(
                  children: [
                    (isDeliveryFree)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/persent.png",
                                    scale: 12,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${formatNumber(removeSpacesAndConvertToInt(widget.afterFree) - totalPrice)} So`mdan keyin bepul yetkarip beriladi",
                                    style: TextStyle(
                                        color: Color(0xff3c486b),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/delivery.svg",
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xff3c486b),
                                      BlendMode.srcIn,
                                    ),
                                    placeholderBuilder:
                                        (BuildContext context) =>
                                            const Icon(Icons.error),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "Yekazib berish: ",
                                    style: TextStyle(
                                        color: Color(0xff3c486b),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${widget.deliveryPrice} so`m",
                                    style: TextStyle(
                                        color: Color(0xff3c486b),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              )
                            ],
                          ),
                    const Text(
                      "Jami:",
                      style: TextStyle(fontSize: 24, color: Color(0xff3c486b)),
                    ),
                    Text(
                      "${formatNumber(totalPrice + (isDeliveryFree ? 0 : removeSpacesAndConvertToInt(widget.deliveryPrice)))} So`m",
                      style: TextStyle(fontSize: 36, color: Color(0xff3c486b)),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: CustomButton(
                        disabled: products.isEmpty,
                        text: "Buyurtma berish",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPayment(
                                        id: widget.id,
                                        isDeliveryFree: isDeliveryFree,
                                        deliveryPrice: widget.deliveryPrice,
                                        basket: products,
                                        totalPrice: totalPrice,
                                        maxDeliveryTime: widget.maxDeliveryTime,
                                      )));
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

void _showAlertDialog(
    BuildContext context, String subtitle, VoidCallback onSubmit) {
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
        content: SizedBox(
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
                  fixedSize: WidgetStateProperty.all(const Size.fromHeight(51)),
                  backgroundColor:
                      const WidgetStatePropertyAll(Color(0xffff9556)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
                  fixedSize: WidgetStateProperty.all(const Size.fromHeight(51)),
                  backgroundColor:
                      const WidgetStatePropertyAll(Color(0xfff8f8fa)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                ),
                onPressed: onSubmit,
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

class BasketItem extends StatelessWidget {
  final String name;
  final int count;
  final String measurementValue;
  final String unitOfMeasure;
  final String price;
  final String photo;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const BasketItem(
      {super.key,
      required this.name,
      required this.count,
      required this.measurementValue,
      required this.unitOfMeasure,
      required this.price,
      required this.photo,
      required this.onAdd,
      required this.onRemove,
      required this.onDelete});

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
                  image: DecorationImage(image: NetworkImage(photo))),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    IconButton(
                        onPressed: onDelete, icon: const Icon(Icons.close))
                  ],
                ),
                Text(
                  "$measurementValue $unitOfMeasure",
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
                                  onPressed: onRemove,
                                  icon: const Icon(Icons.remove,
                                      color: Color(0xff3c486b))),
                            ),
                          ),
                          SizedBox(
                              width: 24,
                              child: Center(
                                child: Text("$count",
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
                                onPressed: onAdd,
                                icon: const Icon(Icons.add,
                                    color: Color(0xff3c486b))),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "$price So`m",
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
