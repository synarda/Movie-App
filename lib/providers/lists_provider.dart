import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/lists_model.dart';
import 'package:provider_api/services/user_service.dart';

class ListsProvider with ChangeNotifier {
  bool isDisposed = false;

  ListsProvider(String id) {
    getLists(id);
  }

  List<ListsModel> lists = [];
  final sessionId = Hive.box("sessionBox").get("sessionId");
  Future<void> getLists(String? id) async {
    final result = await UserService.getLists(id, sessionId);

    if (result != null) {
      lists.addAll(result);
    } else {
      lists.clear();
    }
    if (!isDisposed) notifyListeners();
  }

  Future<void> deleteList(int listId) async {
    await UserService.deleteList(listId, sessionId);
    lists.removeWhere((element) => element.id == listId);
    if (!isDisposed) notifyListeners();
  }

  Future<void> createList(String name, String description) async {
    if (name.isEmpty && description.isEmpty) {
    } else {
      final result = await UserService.createList(name, description, sessionId);
      if (result != null) {
        lists.add(ListsModel(name: name, description: description, id: result, itemCount: 0));
      }
    }
    if (!isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
