// ignore_for_file: public_member_api_docs, sort_constructors_first
class ListsModel {
  final String name;
  final String description;
  final int id;
  final int itemCount;
  const ListsModel({
    required this.name,
    required this.description,
    required this.id,
    required this.itemCount,
  });
  factory ListsModel.fromJson(Map<dynamic, dynamic> json) {
    return ListsModel(
      name: json["name"],
      description: json["description"],
      id: json["id"],
      itemCount: json["item_count"],
    );
  }
}
