import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_api/utils/const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.limit,
    this.icon,
    this.controller,
    required this.obscure,
    this.type,
    this.focus = false,
  });

  final String label;
  final Widget? icon;
  final TextEditingController? controller;
  final int limit;
  final bool obscure;
  final TextInputType? type;
  final bool focus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: focus,
        keyboardType: type,
        obscureText: obscure,
        style: const TextStyle(color: Colorss.textColor, fontSize: 12),
        inputFormatters: [
          LengthLimitingTextInputFormatter(limit),
        ],
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          labelStyle: const TextStyle(color: Colorss.textColor),
          filled: false,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colorss.textColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colorss.textColor),
          ),
        ),
        cursorColor: Colorss.themeFirst,
        onChanged: (value) {},
        controller: controller,
      ),
    );
  }
}
