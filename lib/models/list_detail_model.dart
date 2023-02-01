// ignore_for_file: public_member_api_docs, sort_constructors_first
class ListDetailModel {
  final String title;
  final List items;
  const ListDetailModel({
    required this.title,
    required this.items,
  });
  factory ListDetailModel.fromJson(Map<dynamic, dynamic> json) {
    return ListDetailModel(
      title: json["created_by"],
      items: json["items"],
    );
  }
}
