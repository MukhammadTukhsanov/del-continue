import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? disabled;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (disabled ?? false) ? null : onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(const Size.fromHeight(51)),
        backgroundColor: WidgetStateProperty.all(disabled ?? false
            ? const Color(0x90ff9556)
            : const Color(0xffff9556)),
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
