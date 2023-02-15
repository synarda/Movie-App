import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_provider.dart';
import 'package:provider_api/utils/const.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: const Color(0xff142747),
          appBar: AppBar(
            backgroundColor: Colorss.background,
            title: const Text("Game"),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () {
              provider.anim(context);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned.fill(
                      bottom: 0,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Lottie.asset("assets/Kio.json", fit: BoxFit.contain))),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
                    child: Column(
                      children: [
                        Text(
                          "We want you to be able to navigate between two given pages in less than 10 minutes.",
                          style: TextStyle(color: Colorss.textColor.withOpacity(0.5), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    height: 220,
                    width: 220,
                    left: MediaQuery.of(context).size.width / 4,
                    top: MediaQuery.of(context).size.height / provider.playPosition,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 350),
                      opacity: 1 - provider.opacity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colorss.background.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Lottie.asset("assets/play.json"),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    height: 220,
                    width: 220,
                    bottom: MediaQuery.of(context).size.height / provider.iconPosition,
                    left: MediaQuery.of(context).size.width / 4,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 350),
                      opacity: provider.opacity,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colorss.background.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: Text(
                            "Play",
                            style: TextStyle(color: Colorss.textColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
