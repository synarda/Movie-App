import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/services/user_service.dart';

class RoutePageProvider with ChangeNotifier {
  int pageIdx = 0;
  final controller = PageController(initialPage: 0);
  double searchAnimWidth = 0.0;
  double moviesTxtOpacity = 1.0;
  List<MoviesModel> searchResList = [];
  TextEditingController searchController = TextEditingController();

  Timer? searchTimer;

  RoutePageProvider() {
    searchController.addListener(() async {
      if (searchController.text.isEmpty) {
        searchResList.clear();
        notifyListeners();
      } else {
        searchTimer?.cancel();
        searchTimer = Timer(const Duration(milliseconds: 150), () async {
          await getSearchResult();
          notifyListeners();
        });
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchAnimated() {
    if (searchAnimWidth == 0.0) {
      searchAnimWidth = 170.0;
      moviesTxtOpacity = 0.0;
    } else {
      searchAnimWidth = 0.0;
      moviesTxtOpacity = 1.0;
    }
    notifyListeners();
    notifyListeners();
  }

  Future<void> getSearchResult() async {
    searchResList.clear();

    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    final result = await UserService.getSearchResult(sessionId, searchController.text);

    if (result != null) {
      searchResList.addAll(result);
    }
  }
}
