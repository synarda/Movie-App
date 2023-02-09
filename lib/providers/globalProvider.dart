import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/services/movie_service.dart';

class GlobalProvider with ChangeNotifier {
  final List<MovieModel> favoriteList = [];

  Future<void> getFavoriteList(String accountId) async {
    favoriteList.clear();
    final result = await MovieService.getFavorite(accountId);
    if (result != null) {
      favoriteList.addAll(result);
      notifyListeners();
    }
  }

  Future<void> postRating(int mediaId, double rate, MovieModel movie) async {
    await MovieService.postRateMovie(mediaId, rate);
    final result = ratedList.indexWhere((element) => element.id == mediaId);
    if (result == -1) {
      ratedList.add(movie..rate = rate);
    } else {
      ratedList[result].rate = rate;
    }

    notifyListeners();
  }

  final List<MovieModel> ratedList = [];
  Future<void> getRatedMovies(String accountId) async {
    ratedList.clear();
    final result = await MovieService.getRatedMovies(accountId);
    if (result != null) {
      ratedList.addAll(result);
      notifyListeners();
    }
  }

  bool isFavorite(int movieId) {
    return favoriteList.any((element) => element.id == movieId);
  }

  Future postMarkFavorite(MovieModel movie, String accountId) async {
    final sessionId = Hive.box("sessionBox").get("sessionId");
    final isFav = !favoriteList.any((element) => element.id == movie.id);
    await MovieService.postMarkFavorite(sessionId, movie.id, accountId, isFav);
    if (isFav) {
      favoriteList.add(movie);
    } else {
      favoriteList.removeWhere((element) => element.id == movie.id);
    }
    notifyListeners();
  }

  Future<void> deleteRate(movieId, MovieModel movie) async {
    await MovieService.deleteRate(movieId);
    ratedList.remove(movie);
    notifyListeners();
  }
}
