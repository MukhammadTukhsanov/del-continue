import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyPlace extends StatefulWidget {
  final String svgSrc;
  const EmptyPlace({super.key, required this.svgSrc});

  @override
  _EmptyPlaceState createState() => _EmptyPlaceState();
}

class _EmptyPlaceState extends State<EmptyPlace> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Color(0x103c486b),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(child: SvgPicture.asset(widget.svgSrc))),
            Text(
              "Xozircha bu yer bo`sh!",
              style: TextStyle(
                  color: Color(0xff3c486b),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ]),
    );
  }
}
