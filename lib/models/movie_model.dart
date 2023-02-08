// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final int? budget;
  final String description;
  final String? status;
  final int? runtime;
  final String releaseDate;
  final int? revenue;
  final String? tagLine;
  final double popularity;
  final double voteAverage;
  final List<dynamic>? genres;
  final int id;
  double? rate;

  MovieModel({
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.budget,
    required this.description,
    required this.status,
    required this.runtime,
    required this.releaseDate,
    required this.revenue,
    required this.tagLine,
    required this.popularity,
    required this.voteAverage,
    required this.genres,
    required this.id,
    this.rate,
  });
  factory MovieModel.fromJson(Map<dynamic, dynamic> json) {
    return MovieModel(
      title: json["title"],
      id: json["id"],
      backdropPath: json["backdrop_path"],
      posterPath: json["poster_path"],
      budget: json["budget"],
      description: json["overview"],
      status: json["status"],
      runtime: json["runtime"],
      releaseDate: json["release_date"],
      revenue: json["revenue"],
      tagLine: json["tagline"],
      popularity: json["popularity"],
      rate: json["rating"],
      voteAverage:
          json["vote_average"] is int ? json["vote_average"].toDouble() : json["vote_average"],
      genres: json["genres"],
    );
  }

  @override
  int get hashCode {
    return title.hashCode ^
        backdropPath.hashCode ^
        posterPath.hashCode ^
        budget.hashCode ^
        description.hashCode ^
        status.hashCode ^
        runtime.hashCode ^
        releaseDate.hashCode ^
        revenue.hashCode ^
        tagLine.hashCode ^
        popularity.hashCode ^
        voteAverage.hashCode ^
        genres.hashCode ^
        id.hashCode ^
        rate.hashCode;
  }

  void arda() {}
  void adil() {}
}
