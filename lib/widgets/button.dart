// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.txt,
    required this.func,
    required this.widget,
  }) : super(key: key);
  final String txt;
  final Function() func;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: GestureDetector(
        onTap: func,
        child: Container(
          height: 28,
          width: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colorss.themeFirst),
              boxShadow: [
                BoxShadow(
                  color: Colorss.forebackground.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: Colorss.background),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                txt,
                style: const TextStyle(color: Colorss.textColor, fontSize: 8),
              ),
              const SizedBox(width: 8),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
