// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:provider_api/models/movie_model.dart';

class ListDetailModel {
  final String createdBy;
  final String name;
  final String description;
  final List<MovieModel> items;
  final int itemCount;
  final String id;
  const ListDetailModel({
    required this.createdBy,
    required this.name,
    required this.description,
    required this.items,
    required this.itemCount,
    required this.id,
  });
  factory ListDetailModel.fromJson(Map<dynamic, dynamic> json) {
    return ListDetailModel(
      createdBy: json["created_by"],
      items: (json["items"] as List<dynamic>).map((e) => MovieModel.fromJson(e)).toList(),
      name: json["name"],
      description: json["description"],
      itemCount: json["item_count"],
      id: json["id"],
    );
  }
}
