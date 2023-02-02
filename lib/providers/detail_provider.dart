import 'package:cancellation_token/cancellation_token.dart';
import 'package:flutter/material.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/services/api_service.dart';

class DetailProvider with ChangeNotifier {
  DetailProvider(int id) {
    fetchMovie(id).then((value) => fetchSimilar(id));
  }

  @override
  void dispose() {
    cancellationToken.cancel();
    super.dispose();
  }

  final List<MoviesModel> similarList = [];
  final List<MovieModel> movieList = [];
  CancellationToken cancellationToken = CancellationToken();
  void blurAnimated() {}

  Future<void> fetchSimilar(int id) async {
    similarList.clear();

    final result = await ApiService.fetchSimilar(id);

    if (result != null) {
      similarList.addAll(result);
    }
    notifyListeners();
  }

  Future<void> fetchMovie(int id) async {
    movieList.clear();

    final result = await ApiService.fetchMovie(id);

    if (result != null) {
      movieList.add(result);
    }
  }
}
