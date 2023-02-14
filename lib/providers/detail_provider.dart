import 'package:flutter/material.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/models/people_model.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/screen/alerts/game_get_back_alert.dart';
import 'package:provider_api/services/api_service.dart';
import 'package:provider_api/services/movie_service.dart';

class DetailProvider with ChangeNotifier {
  DetailProvider(int id, this.globalProvider) {
    fetchMovie(id).then((value) => fetchSimilar(id).then((value) => fetchPeople(id)));
  }

  final List<MoviesModel> similarList = [];
  MovieModel? movie;
  List<PeopleModel>? peoples;

  final GlobalProvider globalProvider;
  Future<void> fetchSimilar(int id) async {
    similarList.clear();

    final result = await ApiService.fetchSimilar(id);

    if (result != null) {
      similarList.addAll(result);
    }
    notifyListeners();
  }

  Future<void> fetchMovie(int id) async {
    final result = await ApiService.fetchMovie(id);

    if (result != null) {
      movie = result;
    }
  }

  Future<void> fetchPeople(int movieId) async {
    final result = await MovieService.getPeople(movieId);
    if (result != null) {
      peoples = result;
      print(peoples);
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
