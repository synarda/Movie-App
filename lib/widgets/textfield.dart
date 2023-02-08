// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider_api/utils/const.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    Key? key,
    required this.label,
    this.icon = const Icon(Icons.person),
    this.controller,
    required this.limit,
    required this.obscure,
    this.type,
    this.focus = false,
    this.onChanged,
    this.suffixIconFunc,
  }) : super(key: key);

  final String label;
  final Widget icon;
  final TextEditingController? controller;
  final int limit;
  final bool obscure;
  final TextInputType? type;
  final bool focus;
  final Function? onChanged;
  final void Function()? suffixIconFunc;

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
          suffixIcon: IconButton(
            icon: icon,
            onPressed: suffixIconFunc,
          ),
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
        onChanged: (value) {
          onChanged?.call();
        },
        controller: controller,
      ),
    );
  }
}
