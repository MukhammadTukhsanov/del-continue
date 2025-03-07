import 'package:flutter/material.dart';
import 'package:geo_scraper_mobile/data/models/list_item_model.dart';
import 'package:geo_scraper_mobile/presentation/widgets/vertical_list_item.dart';

class FiltredMarkets extends StatefulWidget {
  final String title;
  final List data;

  const FiltredMarkets({super.key, required this.title, required this.data});

  @override
  _FiltredMarketsState createState() => _FiltredMarketsState();
}

class _FiltredMarketsState extends State<FiltredMarkets> {
  List<ListItemModel> parsedData = [];
  @override
  void initState() {
    super.initState();
    parsedData = (widget.data).map((e) => ListItemModel.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(widget.title),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: const Color(0xffd8dae1),
              ))),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          spacing: 12,
          children: parsedData
              .map((e) => VerticalListItem(listItemModel: e))
              .toList(),
        ),
      ),
    );
  }
}
