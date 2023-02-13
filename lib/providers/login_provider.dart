import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/models/account_model.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/services/api_service.dart';
import 'package:provider_api/services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final sessionBox = Hive.box("sessionBox");
  final GlobalProvider globalProvider;
  String token = "";
  late AccountModel account;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = true;

  LoginProvider(this.globalProvider) {
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
    ApiService.sessionId = sessionId;

    final result = await AuthService.getAccount();
    if (result != null) {
      account = result;
      isLoading = false;
      globalProvider.getFavoriteList(account.id);
      globalProvider.getRatedMovies(account.id);
      print("sessionIDem $sessionId");
      print(account.id);
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
