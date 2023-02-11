// ignore_for_file: public_member_api_docs, sort_constructors_first
class PeopleModel {
  final String name;
  final String? profilePath;
  final String character;
  final int id;
  PeopleModel({
    required this.name,
    required this.profilePath,
    required this.character,
    required this.id,
  });

  factory PeopleModel.fromJson(Map<dynamic, dynamic> json) {
    return PeopleModel(
      name: json["name"],
      id: json["id"],
      profilePath: json["profile_path"],
      character: json["character"],
    );
  }
}
