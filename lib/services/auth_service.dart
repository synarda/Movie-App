import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/account_model.dart';

class AuthService {
  static Future<String?> getToken() async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/authentication/token/new",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        dynamic token = result["request_token"];

        return token.toString();
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<AccountModel?> getAccount(String? sessionId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/account",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        return AccountModel.fromJson(result);
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<String?> postSession(String token) async {
    try {
      final response = await http.post(
          Uri.http("api.themoviedb.org", "/3/authentication/session/new",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "request_token": token,
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        String session = result["session_id"];
        return session;
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<String?> postAuth(String token, String username, String password) async {
    try {
      final response = await http.post(
          Uri.http("api.themoviedb.org", "/3/authentication/token/validate_with_login",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "username": username,
            "password": password,
            "request_token": token,
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        String auth = result["request_token"];
        return auth;
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future deleteList(String sessionId) async {
    try {
      http.delete(
          Uri.http("api.themoviedb.org", "/3/authentication/session",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "session_id": sessionId
          });
    } catch (err) {
      print(err);
    }

    return null;
  }
}
