import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Internet Connection',
        style: TextStyle(fontSize: 22, color: Colors.red),
      ),
    );
  }
}
