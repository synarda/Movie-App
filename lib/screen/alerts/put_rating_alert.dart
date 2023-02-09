// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider_api/utils/const.dart';

class PutRatingAlert extends StatefulWidget {
  const PutRatingAlert({
    Key? key,
  }) : super(key: key);

  @override
  State<PutRatingAlert> createState() => _PutRatingAlertState();
}

class _PutRatingAlertState extends State<PutRatingAlert> {
  double? rate = 0;

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
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colorss.themeFirst)),
              child: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Rate this movie",
                    style: TextStyle(color: Colorss.textColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
                    child: RatingBar.builder(
                      glow: false,
                      initialRating: 0,
                      minRating: 1,
                      unratedColor: Colorss.textColor,
                      itemSize: 25,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colorss.themeFirst,
                      ),
                      onRatingUpdate: (rating) {
                        rate = rating;
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                            Navigator.pop(context, rate ?? 0);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colorss.forebackground,
                              textStyle:
                                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          child: Text(
                            "Send rating",
                            style: TextStyle(color: Colorss.themeFirst, fontSize: 12),
                          )),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
