import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/presentation/pages/all_items.dart';

enum ListTitleTyps { markets, kitchens }

class ListTitle extends StatelessWidget {
  final String title;
  final bool icon;
  final ListTitleTyps? type;

  const ListTitle(
      {super.key, required this.title, this.icon = true, this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == ListTitleTyps.markets || type == ListTitleTyps.kitchens) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllItems(
                      type: type == ListTitleTyps.kitchens
                          ? AllItemsType.kitchens
                          : AllItemsType.markets)));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
        ),
      ),
    );
  }
}
