import 'package:flutter/cupertino.dart';
import 'package:provider_api/models/list_detail_model.dart';
import 'package:provider_api/services/user_service.dart';

class ListDetailProvider with ChangeNotifier {
  ListDetailProvider(String listId, String sessionId) {
    getListDetail(listId, sessionId);
  }

  List<ListDetailModel?> listDetail = [];
  Future<void> getListDetail(String listId, String sessionId) async {
    final result = await UserService.getListDetail(listId, sessionId);

    listDetail.add(result);
    notifyListeners();
    print("bu çektiğim veri $listDetail");
  }
}
