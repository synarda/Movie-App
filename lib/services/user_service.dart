import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/list_detail_model.dart';
import 'package:provider_api/models/lists_model.dart';
import 'package:provider_api/models/movies_model.dart';

class UserService {
  static Future<int?> createList(String name, String description, String sessionID) async {
    try {
      final response = await http.post(
          Uri.http("api.themoviedb.org", "/3/list",
              {"api_key": "Your Api KEY", "session_id": sessionID}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "name": name,
            "description": description,
          });
      final result = jsonDecode(response.body);

      if (response.statusCode == 201) {
        dynamic list = result;

        return list["list_id"];
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<int?> addMovie(String listId, String sessionID, String mediaId) async {
    try {
      final response = await http.post(
          Uri.http("api.themoviedb.org", "/3/list/$listId/add_item",
              {"api_key": "Your Api KEY", "session_id": sessionID}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "media_id": mediaId,
          });
      final result = jsonDecode(response.body);

      if (response.statusCode == 201) {
        dynamic list = result;

        return list["media_id"];
      }
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<List<ListsModel>?> getLists(String? id, String sessionId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/account/$id/lists",
              {"api_key": "Your Api KEY", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        List<dynamic> lists = result["results"];

        return lists.map((e) => ListsModel.fromJson(e)).toList();
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<List<MoviesModel>?> getSearchResult(String sessionId, String query) async {
    try {
      final response = await http.get(Uri.http("api.themoviedb.org", "/3/search/movie", {
        "api_key": "Your Api KEY",
        "session_id": sessionId,
        "query": query
      }));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> searchResultList = result["results"] as List<dynamic>;
        return searchResultList.map((e) {
          return MoviesModel.fromJson(e);
        }).toList();
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future<ListDetailModel?> getListDetail(String listId, String sessionId) async {
    try {
      final response = await http.get(
          Uri.http("api.themoviedb.org", "/3/list/$listId",
              {"api_key": "Your Api KEY", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Map listDetail = result as Map;

        return ListDetailModel.fromJson(listDetail);
      }
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future deleteList(int? listId, String sessionId) async {
    try {
      http.delete(
          Uri.http("api.themoviedb.org", "/3/list/$listId",
              {"api_key": "Your Api KEY", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          });
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future deleteSession(String sessionId) async {
    try {
      http.delete(
          Uri.http("api.themoviedb.org", "/3/authentication/session",
              {"api_key": "Your Api KEY", "session_id": sessionId}),
          headers: {
            'Accept': 'application/json',
          });
    } catch (err) {
      print(err);
    }

    return null;
  }

  static Future deleteListInMovie(String listId, String sessionID, int mediaId) async {
    try {
      await http.post(
          Uri.http("api.themoviedb.org", "/3/list/$listId/remove_item",
              {"api_key": "Your Api KEY", "session_id": sessionID}),
          headers: {
            'Accept': 'application/json',
          },
          body: {
            "media_id": mediaId.toString(),
          });
    } catch (err) {
      print(err);
    }

    return null;
  }
}
