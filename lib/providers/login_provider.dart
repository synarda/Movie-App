import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/account_model.dart';
import 'package:provider_api/services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final sessionBox = Hive.box("sessionBox");

  String token = "";
  AccountModel? account;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginProvider() {
    {
      getToken();
      getAccount();
    }
  }
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> getToken() async {
    final result = await AuthService.getToken();
    token = result!;

    notifyListeners();
  }

  Future<void> getAccount() async {
    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    final result = await AuthService.getAccount(sessionId);
    account = result!;

    notifyListeners();
  }

  Future<void> postAuth(String token, String userName, String password) async {
    await AuthService.postAuth(token, userName, password).then((value) {
      if (value != null) {
        postSession(token);
      }
    });

    notifyListeners();
  }

  Future<String?> postSession(String token) async {
    final result = await AuthService.postSession(token);
    if (result != null) {
      sessionBox.put("sessionId", result);
    } else {
      print("error");
    }

    notifyListeners();
    return result;
  }
}
