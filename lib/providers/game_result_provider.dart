import 'package:flutter/material.dart';

class GameResultProvider with ChangeNotifier {
  GameResultProvider(count) {
    anim(count);
  }
  String txt = "";
  Color txtColor = Colors.black;
  void anim(count) {
    if (count <= 5) {
      txt = "Well done";
      txtColor = Colors.green;
    } else if (count > 5 && count <= 10) {
      txtColor = Colors.yellow;
      txt = "Nice";
    } else if (count < 10 && count <= 15) {
      txtColor = Colors.orange;
      txt = "Not bad";
    } else if (count > 15 && count <= 20) {
      txtColor = Colors.red;
      txt = "Like a shit";
    }
    notifyListeners();
  }
}
