// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class CustomAccountListtile extends StatelessWidget {
  const CustomAccountListtile({
    Key? key,
    required this.icon,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: Colorss.background.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
            child: icon),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(top: 16, right: 16, left: 5),
            height: 50,
            decoration: const BoxDecoration(
                color: Colorss.background,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
