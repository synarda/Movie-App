// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class PutRatingAlert extends StatelessWidget {
  const PutRatingAlert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        "Are u Sure?",
        style: TextStyle(color: Colorss.textColor),
      ),
      backgroundColor: Colorss.background.withOpacity(0.7),
      content: GestureDetector(
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
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  child: const Text(
                    "Send rating",
                    style: TextStyle(color: Colorss.themeFirst, fontSize: 12),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
