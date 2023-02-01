import 'package:flutter/cupertino.dart';
import 'package:provider_api/services/user_service.dart';

class AddMovieProvider with ChangeNotifier {
  AddMovieProvider();

  Future<void> addMovie(String listId, String sessionId, String mediaId) async {
    await UserService.addMovie(listId, sessionId, mediaId);
  }
}
