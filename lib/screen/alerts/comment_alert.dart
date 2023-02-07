// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class CommentAlert extends StatelessWidget {
  const CommentAlert({
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
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorss.background.withOpacity(0.5),
              ),
            ),
          ),
        ),
        AlertDialog(
          backgroundColor: Colorss.background.withOpacity(0.7),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colorss.themeFirst)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.clear,
                          color: Colorss.textColor,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(
                          createdAt.substring(0, 10),
                          style: TextStyle(color: Colorss.textColor.withOpacity(0.5), fontSize: 10),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: ListView(
                        shrinkWrap: false,
                        physics:
                            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              content,
                              style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
