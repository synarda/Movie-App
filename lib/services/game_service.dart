import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/game_model.dart';

class GameService {
  static Future<List<GameModel>?> getGameData() async {
    try {
      final response = await http.get(Uri.http("192.168.1.106", "/data.json"), headers: {
        'Accept': 'application/json',
      });

      final result = jsonDecode(response.body);
      List<dynamic> list = result as List<dynamic>;
      return list.map((e) => GameModel.fromJson(e)).toList();
    } catch (err) {
      print(err);
    }
    return null;
  }
}
