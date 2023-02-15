import 'package:flutter/material.dart';

class GameResultProvider with ChangeNotifier {
  GameResultProvider(time, BuildContext context) {
    anim(time, context);
  }
  String txt = "";
  Color txtColor = Colors.black;
  void anim(time, BuildContext context) {
    print("bu bana gelen time $time");
    if (time <= 0) {
      txt = "Time is over";
      txtColor = Colors.red;
    } else if (time > 0 && time <= 60) {
      txt = "Well done";
      txtColor = Colors.green;
    } else if (time > 60 && time <= 120) {
      txtColor = Colors.yellow;
      txt = "Nice";
    } else if (time < 120 && time <= 320) {
      txtColor = Colors.orange;
      txt = "Not bad";
    } else if (time > 320 && time <= 600) {
      txtColor = Colors.red;
      txt = "Like a shit";
    }

    notifyListeners();
  }
}
