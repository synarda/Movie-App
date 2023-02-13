class MoviePeopleModel {
  final int id;
  final bool isMovie;
  final String poster;

  MoviePeopleModel({
    required this.id,
    required this.isMovie,
    required this.poster,
  });
  factory MoviePeopleModel.fromJson(Map<dynamic, dynamic> json) {
    return MoviePeopleModel(id: json["id"], isMovie: json["isMovie"], poster: json["poster"]);
  }
}
