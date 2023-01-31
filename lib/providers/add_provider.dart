import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/lists_model.dart';
import 'package:provider_api/services/user_service.dart';

class AddProvider with ChangeNotifier {
  AddProvider(String id) {
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
    notifyListeners();
  }

  Future<void> deleteList(int listId) async {
    await UserService.deleteList(listId, sessionId);
    lists.removeWhere((element) => element.id == listId);
    notifyListeners();
  }

  final sessionBox = Hive.box("sessionBox");

  Future<void> createList(String name, String description) async {
    final sessionID = sessionBox.get("sessionId");
    if (name.isEmpty && description.isEmpty) {
    } else {
      final result = await UserService.createList(name, description, sessionID);
      print("ardaaaa$result");
      if (result != null) {
        lists.add(ListsModel(name: name, description: description, id: result, itemCount: 0));
        print("l,stem$lists");
      }
    }
    notifyListeners();
  }
}
