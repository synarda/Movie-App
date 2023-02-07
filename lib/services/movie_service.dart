import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_api/models/reviews_model.dart';
import 'package:provider_api/services/api_service.dart';

class MovieService {
  static Future<List<ReviewsModel>?> getReview(int movieId) async {
    final response = await http.get(
        Uri.http("api.themoviedb.org", "/3/movie/$movieId/reviews",
            {"api_key": "9c829acfb2666008b8b6304b45fc15a7", "session_id": ApiService.sessionId}),
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
}
