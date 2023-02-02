// ignore_for_file: public_member_api_docs, sort_constructors_first
class MoviesModel {
  final String title;
  final String imgUrl;
  final int id;
  final List<int> genres;
  final bool adult;
  final double voteAverage;

  const MoviesModel({
    required this.title,
    required this.imgUrl,
    required this.id,
    required this.genres,
    required this.adult,
    required this.voteAverage,
  });
  factory MoviesModel.fromJson(Map<dynamic, dynamic> json) {
    return MoviesModel(
      title: json["title"],
      imgUrl: json["backdrop_path"] ?? "",
      id: json["id"],
      adult: json["adult"],
      voteAverage:
          json["vote_average"] is int ? json["vote_average"].toDouble() : json["vote_average"],
      genres: (json["genre_ids"] as List<dynamic>).map((e) => e as int).toList(),
    );
  }
}
