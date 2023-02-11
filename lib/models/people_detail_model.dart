// ignore_for_file: public_member_api_docs, sort_constructors_first
class PeopleDetailModel {
  final String name;
  final String? birthday;
  final String? deathday;
  final String? placeOfBirt;
  final String? profilePath;
  final String? biography;
  final int? gender;
  PeopleDetailModel({
    required this.name,
    required this.birthday,
    required this.deathday,
    required this.placeOfBirt,
    required this.profilePath,
    required this.biography,
    required this.gender,
  });
  factory PeopleDetailModel.fromJson(Map<dynamic, dynamic> json) {
    return PeopleDetailModel(
      name: json["name"],
      birthday: json["birthday"],
      deathday: json["deathday"],
      placeOfBirt: json["place_of_birth"],
      biography: json["biography"],
      gender: json["gender"],
      profilePath: json["profile_path"],
    );
  }
}
