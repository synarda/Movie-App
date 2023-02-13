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
      return GestureDetector(
          onTap: () {
            provider.animated();
            if (provider.count == 6) {
              showDialog(context: context, builder: (context) => const GamePageAlert());
              context.read<GameAlertProvider>().getGameData();
              context.read<GameAlertProvider>().timerToRoute(context);
            }
          },
          child: Scaffold(
              backgroundColor: Colorss.forebackground,
              appBar: AppBar(
                backgroundColor: Colorss.background,
                title: const Text("Game"),
                centerTitle: true,
              ),
              body: Stack(children: [
                Positioned(
                  left: 32,
                  top: 100,
                  child: AnimatedContainer(
                      height: provider.personSize,
                      width: provider.personSize,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset("assets/mimg.png")),
                ),
                Positioned(
                  right: 64,
                  top: 32,
                  child: AnimatedContainer(
                      height: provider.movieSize,
                      width: provider.movieSize,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset("assets/mimg01.png")),
                ),
                Positioned(
                  left: 64,
                  bottom: 78,
                  child: AnimatedContainer(
                      height: provider.ruleSize,
                      width: provider.ruleSize,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset("assets/mimg02.png")),
                ),
                Positioned(
                  right: 32,
                  bottom: 200,
                  child: AnimatedContainer(
                      height: provider.timeSize,
                      width: provider.timeSize,
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset("assets/mimg03.png")),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colorss.background,
                    ),
                    height: 200,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Text(
                                provider.ruleText,
                                style: TextStyle(color: Colorss.themeFirst),
                              ),
                            ),
                            Visibility(
                              visible: provider.nextText,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("next", style: TextStyle(fontSize: 12, color: Colorss.themeFirst)),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                      color: Colorss.themeFirst,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ])));
    });
  }
}
