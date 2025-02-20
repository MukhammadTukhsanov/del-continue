import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geo_scraper_mobile/presentation/widgets/custom_button.dart';

class Discounts extends StatelessWidget {
  const Discounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chegirmalar"),
        backgroundColor: Colors.white,
      ),
      body: Center(
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
                  child: Center(
                      child: SvgPicture.asset("assets/icons/percent.svg"))),
              Text(
                "Xozircha bu yer bo`sh!",
                style: TextStyle(
                    color: Color(0xff3c486b),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ]),
      ),
    );
  }
}
