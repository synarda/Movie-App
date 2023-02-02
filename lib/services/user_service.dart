import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/list_detail_model.dart';
import 'package:provider_api/models/lists_model.dart';
import 'package:provider_api/models/movies_model.dart';

class UserService {
  static Future<int?> createList(String name, String description, String sessionID) async {
    final response = await http.post(
        Uri.http("api.themoviedb.org", "/3/list",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionID}),
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
    return null;
  }

  static Future<int?> addMovie(String listId, String sessionID, String mediaId) async {
    final response = await http.post(
        Uri.http("api.themoviedb.org", "/3/list/$listId/add_item",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionID}),
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
    return null;
  }

  static Future<List<ListsModel>?> getLists(String? id, String sessionId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/account/$id/lists",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      List<dynamic> lists = result["results"];

      return lists.map((e) => ListsModel.fromJson(e)).toList();
    }
    return null;
  }

  static Future<List<MoviesModel>?> getSearchResult(String sessionId, String query) async {
    final response = await http.get(Uri.http("api.themoviedb.org", "/3/search/movie",
        {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId, "query": query}));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<dynamic> searchResultList = result["results"] as List<dynamic>;
      return searchResultList.map((e) {
        return MoviesModel.fromJson(e);
      }).toList();
    }
    return null;
  }

  static Future<ListDetailModel?> getListDetail(String listId, String sessionId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/list/$listId",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
        headers: {
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Map listDetail = result as Map;

      return ListDetailModel.fromJson(listDetail);
    }
    return null;
  }

  static Future deleteList(int? listId, String sessionId) async {
    http.delete(
        Uri.http("api.themoviedb.org", "/3/list/$listId",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionId}),
        headers: {
          'Accept': 'application/json',
        });

    return null;
  }

  static Future deleteListInMovie(String listId, String sessionID, int mediaId) async {
    await http.post(
        Uri.http("api.themoviedb.org", "/3/list/$listId/remove_item",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": sessionID}),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "media_id": mediaId.toString(),
        });
    return null;
  }
}
