import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/movie_model.dart';
import 'package:provider_api/models/movies_model.dart';
import 'package:provider_api/models/people_model.dart';
import 'package:provider_api/models/reviews_model.dart';
import 'package:provider_api/services/api_service.dart';

class MovieService {
  static Future<List<ReviewsModel>?> getReview(int movieId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/movie/$movieId/reviews",
            {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<dynamic> res = result["results"];
      return res.map((e) => ReviewsModel.fromJson(e)).toList();
    }
    return null;
  }

  static Future postMarkFavorite(
      String sessionID, int mediaId, String accountId, bool choose) async {
    try {
      await http.post(
          Uri.http("api.themoviedb.org", "/3/account/$accountId/favorite",
              {"api_key": "Your Api KEY", "session_id": sessionID}),
          headers: {
            "Content-Type": "application/json;charset=utf-8",
          },
          body: jsonEncode({"media_type": "movie", "media_id": mediaId, "favorite": choose}));
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future postRateMovie(int mediaId, double rate) async {
    try {
      await http.post(
          Uri.http("api.themoviedb.org", "/3/movie/$mediaId/rating",
              {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
          headers: {
            "Content-Type": "application/json;charset=utf-8",
          },
          body: jsonEncode({"value": rate}));
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<List<MovieModel>?> getFavorite(String accountId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/account/$accountId/favorite/movies",
              {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        List<dynamic> lists = result["results"];

        return lists.map((e) => MovieModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<List<MovieModel>?> getRatedMovies(String accountId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/account/$accountId/rated/movies",
              {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        List<dynamic> lists = result["results"];

        return lists.map((e) => MovieModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<List<MoviesModel>?> getDiscoverFilter(String accountId, List<String> genre) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/discover/movie", {
          "api_key": "Your Api KEY",
          "session_id": ApiService.sessionId,
          "with_genres": genre
        }),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      List<dynamic> lists = result["results"];

      return lists.map((e) => MoviesModel.fromJson(e)).toList();
    }

    return null;
  }

  static Future deleteRate(int movieId) async {
    try {
      http.delete(
          Uri.http("api.themoviedb.org", "/3/movie/$movieId/rating",
              {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
          headers: {
            'Accept': 'application/json',
          });
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<List<PeopleModel>?> getPeople(int movieId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/movie/$movieId/credits",
              {"api_key": "Your Api KEY", "session_id": ApiService.sessionId}),
          headers: {
            'Accept': 'application/json',
          });

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> lists = result["cast"];
        return lists.map((e) => PeopleModel.fromJson(e)).toList();
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
