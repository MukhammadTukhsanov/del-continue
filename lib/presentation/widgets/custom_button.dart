import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xffff9556)),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 59)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}
