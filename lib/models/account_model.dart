// ignore_for_file: public_member_api_docs, sort_constructors_first

class AccountModel {
  final String avatarHash;
  final String userName;
  final String country;
  final String id;

  AccountModel({
    required this.avatarHash,
    required this.userName,
    required this.country,
    required this.id,
  });
  factory AccountModel.fromJson(Map<dynamic, dynamic> json) {
    return AccountModel(
      userName: json["username"],
      id: json["id"].toString(),
      avatarHash: (json["avatar"]["gravatar"]["hash"]),
      country: json["iso_3166_1"],
    );
  }
}
