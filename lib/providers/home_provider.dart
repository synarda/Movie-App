import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider_api/models/genre_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/services/api_service.dart';
import 'package:provider_api/services/movie_service.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    fetchHome("upcoming");
    fetchHome("top_rated");
    fetchHome("popular");
    fetchGenres();
  }

  final Map<String, List<MoviesModel>> homeLists = {
    "popular": [],
    "upcoming": [],
    "top_rated": [],
  };
  final List<GenreModel?> genresList = [];
  final List<String> chooseGenreList = [];
  final List<String> chooseGenreListInt = [];
  final List<MoviesModel> chooseGenreListFilter = [];
  Timer? timer;
  double animPadding = 0;
  double filterHeight = 30;

  Future<void> fetchHome(String key) async {
    final result = await ApiService.fetch(key);

    if (result != null) {
      homeLists[key]?.addAll(result);
    } else {
      homeLists[key]?.clear();
    }
    notifyListeners();
  }

  void chooseGenre(String genre, int id) {
    if (chooseGenreList.contains(genre)) {
      chooseGenreList.remove(genre);
      chooseGenreListInt.remove(id.toString());
    } else {
      chooseGenreList.add(genre);
      chooseGenreListInt.add(id.toString());
      animPadding = 24.0;
      filterHeight = 150;
    }
    notifyListeners();
  }

  Future<void> fetchGenres() async {
    final result = await ApiService.fetchGenres();
    if (result != null) {
      genresList.addAll(result);
    } else {
      genresList.clear();
    }
    notifyListeners();
  }

  Future<void> fetchGenreFilter(String accountId, List<String> genre) async {
    timer?.cancel();

    timer = Timer(const Duration(milliseconds: 300), () async {
      final result = await MovieService.getDiscoverFilter(accountId, genre);

      if (result != null) {
        chooseGenreListFilter.clear();
        chooseGenreListFilter.addAll(result);
        notifyListeners();
      }
    });
  }
}
