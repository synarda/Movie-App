// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.data,
    this.padding = 0.0,
    this.titleSize = 10.0,
    this.contentSize = 12.0,
  }) : super(key: key);
  final Map<String, dynamic> data;
  final double padding;
  final double titleSize;
  final double contentSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.entries
              .map(
                (kv) => Container(
                  padding: EdgeInsets.all(padding),
                  child: Row(
                    children: [
                      Text(
                        kv.key,
                        style: TextStyle(color: Colorss.textColor, fontSize: titleSize),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        kv.value?.toString() ?? "",
                        style: TextStyle(color: Colorss.themeFirst, fontSize: contentSize),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
