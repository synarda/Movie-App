import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/genre_model.dart';
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';

class ApiService {
  static String sessionId = "";
  static Future<List<MoviesModel>?> fetch(String filter) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/movie/$filter",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> list = result["results"] as List<dynamic>;
        return list.map((e) => MoviesModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<MovieModel?> fetchMovie(int id) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/movie/$id",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Map list = result as Map;
        return MovieModel.fromJson(list);
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<List<GenreModel>?> fetchGenres() async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/genre/movie/list",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": ApiService.sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> list = result["genres"] as List<dynamic>;
        return list.map((e) => GenreModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<List<MoviesModel>?> fetchSimilar(int id) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/movie/$id/similar",
              {"api_key": "9c829acfb2666008b8b6304b45fc15a7"}),
          headers: {
            'Accept': 'application/json',
          });

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> list = result["results"] as List<dynamic>;
        return list.map((e) => MoviesModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }
    return null;
  }
}
