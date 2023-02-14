// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoviePeopleModel {
  final int id;
  final bool isMovie;
  final String poster;
  final String name;

  MoviePeopleModel({
    required this.id,
    required this.isMovie,
    required this.poster,
    required this.name,
  });
  factory MoviePeopleModel.fromJson(Map<dynamic, dynamic> json) {
    return MoviePeopleModel(name: json["name"], id: json["id"], isMovie: json["isMovie"], poster: json["poster"]);
  }
}
