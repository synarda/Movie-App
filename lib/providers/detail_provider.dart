import 'package:flutter/foundation.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/services/api_service.dart';

class DetailProvider with ChangeNotifier {
  DetailProvider(int id) {
    fetchSimilar(id);
    fetchMovie(id);
    opacity = 0;
    Future.delayed(const Duration(milliseconds: 1)).then((value) {
      opacity = 1;
      notifyListeners();
    });
  }
  final List<MoviesModel> similarList = [];
  final List<MovieModel> movieList = [];

  late double opacity;

  Future<void> fetchSimilar(int id) async {
    similarList.clear();
    notifyListeners();

    final result = await ApiService.fetchSimilar(id);

    if (result != null) {
      similarList.addAll(result);
    }
    notifyListeners();
  }

  Future<void> fetchMovie(int id) async {
    movieList.clear();
    notifyListeners();

    final result = await ApiService.fetchMovie(id);

    if (result != null) {
      movieList.add(result);
    }
    notifyListeners();
  }
}
