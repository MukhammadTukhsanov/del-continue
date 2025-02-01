import 'package:flutter/material.dart';

class MarketProductItem extends StatefulWidget {
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;

  const MarketProductItem({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.count,
  });

  @override
  _MarketProductItemState createState() => _MarketProductItemState();
}

class _MarketProductItemState extends State<MarketProductItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xff3c486b33)),
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://media.istockphoto.com/id/182463420/photo/tangerine-duo-with-leafs.jpg?s=612x612&w=0&k=20&c=d3JZRAqgqZ5RWyN4ryFteCnmFNbeD9e3TNJkS2IC0vU=",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(36)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(25, 0, 0, 0),
                                  spreadRadius: 0,
                                  blurRadius: 4)
                            ]),
                        child: Row(
                          children: [
                            if (widget.count != 0)
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: Center(
                                  child: IconButton(
                                      iconSize: 26,
                                      color: const Color(0xff3c486b),
                                      padding: const EdgeInsets.all(0),
                                      onPressed: widget.onRemove,
                                      icon: const Icon(Icons.remove)),
                                ),
                              ),
                            if (widget.count != 0)
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    height:
                                        32, // Matches the height of the buttons
                                    child: Center(
                                      child: Text(
                                        "${widget.count}",
                                        key: ValueKey<int>(widget.count),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff3c486b),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Center(
                                child: IconButton(
                                    iconSize: 26,
                                    color: const Color(0xff3c486b),
                                    padding: const EdgeInsets.all(0),
                                    onPressed: widget.onAdd,
                                    icon: const Icon(Icons.add)),
                              ),
                            ),
                          ],
                        )))
              ],
            )),
        const SizedBox(height: 2),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Apelsin",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3c486b))),
            Text("1 kg",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff3c486b))),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        const Text(
          "Apelsin barra qirmizi suvlik ta’mi alo darajada sasdasddsadasd",
          style: TextStyle(
              color: Color.fromARGB(153, 60, 72, 107),
              fontSize: 14,
              fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 2),
        const Text(
          "10 000 so'm",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff3c486b)),
        )
      ],
    );
  }
}
