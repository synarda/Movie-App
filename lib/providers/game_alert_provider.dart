import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/models/game_model.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/game_result_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/people_detail_provider.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/screen/game_result_page.dart';
import 'package:provider_api/screen/people_detail_page.dart';
import 'package:provider_api/services/game_service.dart';

class GameAlertProvider with ChangeNotifier {
  GameAlertProvider(context) {
    getGameData();
  }

  List<GameModel>? gameDataList = [];
  Random random = Random();
  int timeToRoute = 5;
  int testTime = 0;
  Timer? testTimer;
  int randomInt = 0;
  GameModel? gameModel;
  int countPage = 0;
  List<Map<String, dynamic>> routeList = [];

  void startTestTimer() {
    testTimer?.cancel();
    testTime = 0;
    testTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      testTime += 1;
      notifyListeners();
    });
  }

  Future<void> getGameData() async {
    final result = await GameService.getGameData();
    if (result != null) {
      gameDataList = result;
      randomInt = random.nextInt(result.length);
      print(randomInt);
      gameModel = gameDataList![randomInt];
    }
    notifyListeners();
  }

  Future<void> timerToRoute(context) async {
    timeToRoute = 5;
    Timer.periodic(const Duration(seconds: 1), (t) {
      timeToRoute -= 1;
      if (timeToRoute == 0) {
        startTestTimer();
        t.cancel();
        Navigator.pop(context);
        if (gameModel!.from.isMovie == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (ctx) => DetailProvider(
                          gameModel!.from.id,
                          context.read<GlobalProvider>(),
                        ),
                        child: DetailPage(
                          isGame: true,
                          imgUrl: gameModel?.from.poster,
                          id: gameModel!.from.id,
                          data: "data",
                          adult: true,
                          accountId: Provider.of<LoginProvider>(context).account.id,
                        ),
                      )));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (ctx) => PeopleDetailProvider(gameModel!.from.id),
                      child: const PeopleDetailPage(
                        isGame: true,
                      ))));
        }
      }

      notifyListeners();
    });
  }

  Future<void> route(bool isGame, int id, BuildContext context, String page, adult, imgUrl, name) async {
    if (!isGame) {
      countPage += 1;
      if (id == gameModel!.to.id) {
        context.read<GameAlertProvider>().testTimer?.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider(create: (_) => GameResultProvider(countPage), child: const GameResultPage()),
            ));
      } else {
        if (page == "detail") {
          routeList.add({"img": imgUrl, "name": name});

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (ctx) => DetailProvider(id, context.read<GlobalProvider>()),
                        child: DetailPage(
                            isGame: isGame == true ? false : true,
                            adult: adult,
                            data: "",
                            id: id,
                            imgUrl: imgUrl,
                            accountId: Provider.of<LoginProvider>(context).account.id),
                      )));
        } else if (page == "people") {
          routeList.add({"img": imgUrl, "name": name});

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => PeopleDetailProvider(id),
                    child: PeopleDetailPage(
                      isGame: isGame == true ? false : true,
                    )),
              ));
        }
      }
    } else {
      if (page == "detail") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (ctx) => DetailProvider(id, context.read<GlobalProvider>()),
                      child: DetailPage(
                          isGame: isGame == true ? false : true,
                          adult: adult,
                          data: "",
                          id: id,
                          imgUrl: imgUrl,
                          accountId: Provider.of<LoginProvider>(context).account.id),
                    )));
      } else if (page == "people") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => PeopleDetailProvider(id),
                  child: PeopleDetailPage(
                    isGame: isGame == true ? false : true,
                  )),
            ));
      }
    }
  }
}
