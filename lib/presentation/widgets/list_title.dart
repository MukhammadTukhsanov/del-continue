import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/pages/markets.dart';

enum ListTitleTyps { markets, kitchens }

class ListTitle extends StatelessWidget {
  String title;
  bool icon;
  ListTitleTyps? type;

  ListTitle({super.key, required this.title, this.icon = true, this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
      child: GestureDetector(
        onTap: () {
          if (type == ListTitleTyps.markets) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Markets()));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xff3c486b),
                  fontWeight: FontWeight.w600),
            ),
            Visibility(
                visible: icon,
                child: Image.asset(
                  "assets/icons/arrow.png",
                  scale: 3,
                ))
          ],
        ),
      ),
    );
  }
}
