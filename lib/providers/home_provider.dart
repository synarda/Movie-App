import 'package:flutter/cupertino.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/services/api_service.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    fetchHome("upcoming");
    fetchHome("top_rated");
    fetchHome("popular");
    fetchGenres();
  }

  @override
  void dispose() {
    print("haha");
    super.dispose();
  }

  final Map<String, List<MoviesModel>> homeLists = {
    "popular": [],
    "upcoming": [],
    "top_rated": [],
  };
  final Map<int, String> genresList = {};

  Future<void> fetchHome(String key) async {
    final result = await ApiService.fetch(key);

    if (result != null) {
      homeLists[key]?.addAll(result);
    } else {
      homeLists[key]?.clear();
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
}
