import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class GameProvider with ChangeNotifier {
  int count = 0;
  String ruleText = "Welcome reach game's";
  bool nextText = true;

  double personSize = 100;
  double movieSize = 100;
  double ruleSize = 100;
  double timeSize = 100;

  void animated() {
    count += 1;
    if (count == 1) {
      personSize = 0;
      ruleText = Texts.infoGame;
    } else if (count == 2) {
      movieSize = 0;
      ruleText = Texts.infoMovie;
    } else if (count == 3) {
      ruleSize = 0;
      ruleText = Texts.infoMovieStar;
    } else if (count == 4) {
      timeSize = 0;
      ruleText = Texts.infoTime;
    }
    notifyListeners();
  }
}
