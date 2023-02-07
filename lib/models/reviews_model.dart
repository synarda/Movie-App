// ignore_for_file: public_member_api_docs, sort_constructors_first

class ReviewsModel {
  final String? avatar;
  final String? userName;
  final String nickName;
  final double? rating;
  final String content;
  final String createdAt;

  ReviewsModel({
    required this.avatar,
    required this.userName,
    required this.nickName,
    required this.rating,
    required this.content,
    required this.createdAt,
  });
  factory ReviewsModel.fromJson(Map<dynamic, dynamic> json) {
    return ReviewsModel(
      userName: (json["author_details"]["name"]),
      avatar: (json["author_details"]["avatar_path"]),
      content: json["content"],
      createdAt: json["created_at"],
      rating: (json["author_details"]["rating"]),
      nickName: (json["author_details"]["username"]),
    );
  }
}
