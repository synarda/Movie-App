import 'package:flutter/material.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/models/people_detail_model.dart';
import 'package:provider_api/screen/alerts/game_get_back_alert.dart';
import 'package:provider_api/services/people_service.dart';

class PeopleDetailProviderr with ChangeNotifier {
  PeopleDetailProviderr(int personId) {
    getPeopleDetail(personId).then((value) => getPeopleCredits(personId));
  }

  PeopleDetailModel? personDetail;
  List<MoviesModel?>? personDetailCast;

  Future<void> getPeopleDetail(int personId) async {
    final result = await PeopleService.getPeople(personId);
    if (result != null) {
      personDetail = result;
      notifyListeners();
    }
  }

  Future<void> getPeopleCredits(int personId) async {
    final result = await PeopleService.getcPeopleCastMovies(personId);
    if (result != null) {
      personDetailCast = result;
    }
    notifyListeners();
  }

  Future<void> inGameWillPop(context, bool isGame) async {
    if (isGame == true) {
      final result = await showDialog(context: context, builder: (context) => const GameGetBackAlert());
      if (result == true) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }
}
