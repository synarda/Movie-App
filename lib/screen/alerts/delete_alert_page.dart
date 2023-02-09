// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class DeleteAlertPage extends StatelessWidget {
  const DeleteAlertPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorss.background.withOpacity(0.5),
              ),
            ),
          ),
        ),
        AlertDialog(
          backgroundColor: Colorss.background.withOpacity(0.7),
          content: Container(
            height: MediaQuery.of(context).size.height / 4.7,
            width: MediaQuery.of(context).size.width / 1.5,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colorss.themeFirst)),
            child: Column(
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "Are u Sure?",
                  style: TextStyle(color: Colorss.textColor),
                ),
                GestureDetector(
                  onTap: FocusScope.of(context).unfocus,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colorss.forebackground,
                                textStyle:
                                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colorss.textColor, fontSize: 12),
                            )),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colorss.forebackground,
                                textStyle:
                                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colorss.themeFirst,
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Colorss.themeFirst, fontSize: 12),
                                ),
                              ],
                            )),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
