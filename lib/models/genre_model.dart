// ignore_for_file: public_member_api_docs, sort_constructors_first

class GenreModel {
  final String genre;
  final int id;

  GenreModel({
    required this.genre,
    required this.id,
  });
  factory GenreModel.fromJson(Map<dynamic, dynamic> json) {
    return GenreModel(
      id: json["id"],
      genre: (json["name"]),
    );
  }
}
