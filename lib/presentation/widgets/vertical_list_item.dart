import 'package:flutter/material.dart';

class VerticalListItem extends StatefulWidget {
  VerticalListItem({super.key});

  @override
  _VerticalListItemState createState() => _VerticalListItemState();
}

class _VerticalListItemState extends State<VerticalListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Dominos_pizza_logo.svg/512px-Dominos_pizza_logo.svg.png",
                  fit: BoxFit.cover)),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Domino’s Pizza",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Icon(Icons.favorite_border)
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Row(
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "kamida - ",
                            style: TextStyle(
                                color: Color(0xff777f98), fontSize: 17)),
                        TextSpan(
                            text: "50 000 so'm",
                            style: TextStyle(
                                color: Color(0xff777f98),
                                fontWeight: FontWeight.bold,
                                fontSize: 17))
                      ]))
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Color(0xff777f98),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text("12 - 34 min",
                          style: TextStyle(
                              color: Color(0xff777f98),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      SizedBox(width: 12),
                      Icon(Icons.circle, size: 6, color: Color(0xff777f98)),
                      SizedBox(width: 12),
                      Image.asset(
                        "assets/images/delivery.png",
                        scale: 1.6,
                      ),
                      SizedBox(width: 6),
                      Text("24 000 so'm",
                          style: TextStyle(
                              color: Color(0xff777f98),
                              fontSize: 14,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffebecf0),
                        border: Border.all(
                            width: 1, color: const Color(0xff5F6986)),
                        borderRadius: BorderRadius.circular(40)),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/persent.png",
                          scale: 1.5,
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                            child: Text(
                                "Tekin yetkazib berish 100 000 so'mdan yuqori buyurtmada",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Color(0xff3c486b),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
