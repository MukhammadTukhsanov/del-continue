import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextInputType? keyboardType;
  final Function? onPressSuffixIcon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool visibility;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.onPressSuffixIcon,
    this.prefixIcon,
    this.suffixIcon,
    this.visibility = false,
    this.controller,
    this.readOnly = false,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.visibility ? _isPasswordHidden : false,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: const TextStyle(color: Color(0xff989FB1)),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: const Color(0xff989FB1))
            : null,
        suffixIcon: widget.visibility
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                  if (widget.onPressSuffixIcon != null) {
                    widget.onPressSuffixIcon!();
                  }
                },
                icon: Icon(
                  _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xff989FB1),
                ),
              )
            : null,
        fillColor: const Color(0xfff5f6f8),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe7e9ee)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe7e9ee), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
    );
  }
}
