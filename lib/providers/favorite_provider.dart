import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/services/user_service.dart';

class FavoriteProvider with ChangeNotifier {
  final List<MovieModel> favoriteList = [];

  Future<void> getFavoriteList(String accountId) async {
    favoriteList.clear();
    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    final result = await UserService.getFavorite(sessionId, accountId);
    print(result);

    if (result != null) {
      favoriteList.addAll(result);
      print(result);
      notifyListeners();
    }
  }

  bool isFavorite(int movieId) {
    return favoriteList.any((element) => element.id == movieId);
  }

  Future postMarkFavorite(MovieModel movie, String accountId) async {
    final sessionId = Hive.box("sessionBox").get("sessionId");
    final isFav = !favoriteList.any((element) => element.id == movie.id);
    await UserService.postMarkFavorite(sessionId, movie.id, accountId, isFav);
    if (isFav) {
      favoriteList.add(movie);
    } else {
      favoriteList.removeWhere((element) => element.id == movie.id);
    }
    notifyListeners();
  }
}
