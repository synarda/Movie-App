import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/services/user_service.dart';

class AccountProvider with ChangeNotifier {
  Future<void> deleteSession() async {
    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    await UserService.deleteSession(sessionId);
    sessionBox.delete("sessionId");
  }
}
