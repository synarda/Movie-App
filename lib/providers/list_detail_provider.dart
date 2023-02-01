import 'package:flutter/cupertino.dart';
import 'package:provider_api/models/list_detail_model.dart';
import 'package:provider_api/services/user_service.dart';

class ListDetailProvider with ChangeNotifier {
  ListDetailProvider(String listId, String sessionId) {
    getListDetail(listId, sessionId);
  }

  ListDetailModel? listDetail;
  Future<void> getListDetail(String listId, String sessionId) async {
    final result = await UserService.getListDetail(listId, sessionId);
    listDetail = result;
    notifyListeners();
  }

  Future<void> deleteListInMovie(String listId, String sessionId, int movieId) async {
    listDetail!.items.removeWhere((element) => element.id == movieId);
    await UserService.deleteListInMovie(listId, sessionId, movieId);

    notifyListeners();
  }
}
