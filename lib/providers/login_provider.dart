import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/account_model.dart';
import 'package:provider_api/services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final sessionBox = Hive.box("sessionBox");

  String token = "";
  late AccountModel account;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = true;

  LoginProvider() {
    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    if (sessionId != null) {
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
    if (result != null) {
      token = result;
    } else {
      print("token error");
    }
  }

  Future<bool> getAccount() async {
    final sessionBox = Hive.box("sessionBox");
    final sessionId = sessionBox.get("sessionId");
    final result = await AuthService.getAccount(sessionId);
    if (result != null) {
      account = result;
      isLoading = false;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> postAuth(String userName, String password) async {
    await getToken();
    final value = await AuthService.postAuth(token, userName, password);
    if (value != null) {
      token = value;
      final sessionID = await postSession(token);
      if (sessionID != null) {
        return getAccount();
      }
    }
    return false;
  }

  Future<String?> postSession(String token) async {
    final result = await AuthService.postSession(token);
    if (result != null) {
      sessionBox.put("sessionId", result);
    } else {
      print("error");
    }

    return result;
  }
}
