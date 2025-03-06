import 'package:flutter/material.dart';

enum CustomButtonType { white, defaultButton, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? disabled;
  final VoidCallback onPressed;
  final CustomButtonType? type;

  const CustomButton(
      {super.key,
      required this.text,
      this.color,
      this.disabled = false,
      required this.onPressed,
      this.type = CustomButtonType.defaultButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (disabled ?? false) ? null : onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(const Size.fromHeight(51)),
        backgroundColor: WidgetStateProperty.all(disabled ?? false
            ? const Color(0x90ff9556)
            : type == CustomButtonType.white || type == CustomButtonType.outline
                ? Colors.white
                : const Color(0xffff9556)),
        side: WidgetStatePropertyAll(BorderSide(
            color: Color(0xffff9556),
            width: type == CustomButtonType.outline ? 2 : 0)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color:
              type == CustomButtonType.white || type == CustomButtonType.outline
                  ? Color(0xffff9556)
                  : Colors.white,
        ),
      ),
    );
  }
}
