import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/providers/game_provider.dart';
import 'package:provider_api/screen/alerts/game_page_alert.dart';
import 'package:provider_api/utils/const.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: Colorss.forebackground,
          appBar: AppBar(
            backgroundColor: Colorss.background,
            title: const Text("Game"),
            centerTitle: true,
          ),
          body: Center(
              child: GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) => const GamePageAlert());
              context.read<GameAlertProvider>().getGameData();
              context.read<GameAlertProvider>().timerToRoute(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colorss.background,
              ),
              height: 200,
              width: 200,
              child: Center(
                child: Text(
                  "Play",
                  style: TextStyle(color: Colorss.themeFirst),
                ),
              ),
            ),
          )));
    });
  }
}
