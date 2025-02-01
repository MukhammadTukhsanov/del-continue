import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final double fontSize;

  TextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xffff9556),
          fontSize: fontSize,
          // decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
