import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/models/game_model.dart';
import 'package:provider_api/providers/detail_provider.dart';
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

  void startTestTimer() {
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
      gameModel = gameDataList![randomInt];
    }
    notifyListeners();
  }

  Future<void> checkMyRoutePage(id, context) async {
    if (id == gameModel!.to.id) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameResultPage()));
    }
  }

  Future<void> timerToRoute(context) async {
    Timer.periodic(const Duration(seconds: 1), (t) {
      timeToRoute -= 1;
      if (timeToRoute == 0) {
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
    startTestTimer();
  }

  Future<void> route(bool isGame, int id, BuildContext context, String page, adult, imgUrl) async {
    if (isGame == false) {
      if (id == gameModel!.to.id) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GameResultPage()));
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
