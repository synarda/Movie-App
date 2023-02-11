import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/models/people_detail_model.dart';
import 'package:provider_api/services/api_service.dart';

class PeopleService {
  static Future<PeopleDetailModel?> getPeople(int personId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/person/$personId",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": ApiService.sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      return PeopleDetailModel.fromJson(result);
    }
    return null;
  }

  static Future<List<MoviesModel>?> getcPeopleCastMovies(int personId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/person/$personId/movie_credits",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": ApiService.sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<dynamic> list = result["cast"];

      return list.map((e) => MoviesModel.fromJson(e)).toList();
    }

    return null;
  }
}
