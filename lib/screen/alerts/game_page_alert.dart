import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/utils/const.dart';

class GamePageAlert extends StatelessWidget {
  const GamePageAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colorss.forebackground,
        content: WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            return false;
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), border: Border.all(color: Colorss.themeFirst, width: 2)),
            child: Consumer<GameAlertProvider>(builder: (context, provider, child) {
              return Column(children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/${provider.gameModel?.from.poster}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  provider.gameModel!.from.name,
                  style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                ),
                const SizedBox(height: 16),
                const Icon(Icons.arrow_downward_rounded, color: Colorss.textColor),
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/${provider.gameModel?.to.poster}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  provider.gameModel!.to.name,
                  style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.themeFirst),
                  child: Center(
                    child: Text(
                      provider.timeToRoute.toString(),
                      style: const TextStyle(color: Colorss.textColor, fontSize: 20),
                    ),
                  ),
                )
              ]);
            }),
          ),
        ));
  }
}
