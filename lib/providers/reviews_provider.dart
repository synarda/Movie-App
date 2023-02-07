import 'package:flutter/foundation.dart';
import 'package:provider_api/models/reviews_model.dart';
import 'package:provider_api/services/movie_service.dart';

class ReviewsProvider with ChangeNotifier {
  ReviewsProvider(movieId) {
    fetchReviews(movieId);
  }
  List<ReviewsModel>? review;

  Future<void> fetchReviews(int movieId) async {
    final result = await MovieService.getReview(movieId);
    if (result != null) {
      review = result;
      notifyListeners();
    }
  }
}
