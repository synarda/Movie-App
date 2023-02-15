import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/screen/alerts/game_page_alert.dart';

class GameProvider with ChangeNotifier {
  double iconPosition = 200;
  double playPosition = 3;

  double opacity = 0;

  int count = 0;
  void anim(BuildContext context) {
    count += 1;

    if (count == 1) {
      iconPosition = 3;
      playPosition = 200;
      opacity = 1;
    } else if (count == 2) {
      showDialog(context: context, builder: (context) => const GamePageAlert());
      context.read<GameAlertProvider>().getGameData();
      context.read<GameAlertProvider>().timerToRoute(context);
    }
    notifyListeners();
  }
}
