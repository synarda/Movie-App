// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider_api/screen/alerts/comment_alert.dart';
import 'package:provider_api/utils/const.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    Key? key,
    required this.avatar,
    required this.userName,
    required this.nickName,
    required this.rating,
    required this.content,
    required this.createdAt,
  }) : super(key: key);
  final String avatar;
  final String userName;
  final String nickName;
  final double rating;
  final String content;
  final String createdAt;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (context) => CommentAlert(
              avatar: avatar,
              userName: userName,
              nickName: nickName,
              rating: rating,
              content: content,
              createdAt: createdAt)),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.forebackground),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: avatar.contains("https:/") == false
                        ? Image.network(
                            "https://www.gravatar.com/avatar/${avatar.split("/").skip(1).join("/")}")
                        : Image.network(avatar.split("/").skip(1).join("/")),
                  ),
                ),
              ),
              Text(
                nickName,
                style: const TextStyle(color: Colorss.textColor, fontSize: 12),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: Text(
              content,
              style: const TextStyle(color: Colorss.textColor, fontSize: 12),
            ),
          ),
        ]),
      ),
    );
  }
}
