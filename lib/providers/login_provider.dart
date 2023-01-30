import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider_api/services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final sessionBox = Hive.box("sessionBox");

  String token = "";
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginProvider() {
    {
      getToken();
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
    print("tokeni aldım $token");

    notifyListeners();
  }

  Future<void> postAuth(String token, String userName, String password) async {
    await AuthService.postAuth(token, userName, password).then((value) {
      print("kayıt işlemini yaptım");
      print(userName);
      print(token);
      print(password);

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
      print("kayıt ettim");
      print(result);
    } else {
      print("hata");
    }

    notifyListeners();
    return result;
  }
}
