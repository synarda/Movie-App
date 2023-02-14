import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class GameGetBackAlert extends StatelessWidget {
  const GameGetBackAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colorss.forebackground,
      content: Container(
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              color: Colorss.forebackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colorss.themeFirst)),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "When you return, the game will be cancelled. are you sure?",
                  style: TextStyle(color: Colorss.textColor, fontSize: 12),
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
                          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text(
                        "Continue",
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
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colorss.themeFirst, fontSize: 12),
                      )),
                ),
              ]),
            ],
          )),
    );
  }
}
