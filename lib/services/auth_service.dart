import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<String?> getToken() async {
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
    return null;
  }

  static Future<String?> getAccount(String sessionId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/account",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      dynamic accountId = result["id"];

      return accountId.toString();
    }
    return null;
  }

  static Future<String?> postSession(String token) async {
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
    return null;
  }

  static Future<String?> postAuth(String token, String username, String password) async {
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
    return null;
  }
}
