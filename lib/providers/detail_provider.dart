import 'package:flutter/material.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/services/api_service.dart';

class DetailProvider with ChangeNotifier {
  DetailProvider(int id, this.globalProvider) {
    fetchMovie(id).then((value) => fetchSimilar(id));
  }

  final List<MoviesModel> similarList = [];
  MovieModel? movie;
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
}
