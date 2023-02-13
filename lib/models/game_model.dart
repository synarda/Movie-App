import 'package:provider_api/models/movie_people_model.dart';

class GameModel {
  final MoviePeopleModel from;
  final MoviePeopleModel to;

  GameModel({
    required this.from,
    required this.to,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(from: MoviePeopleModel.fromJson(json["from"]), to: MoviePeopleModel.fromJson(json["to"]));
  }
}
