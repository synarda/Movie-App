// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/reviews_provider.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/review_widget.dart';

class ReviewsAlertPage extends StatelessWidget {
  const ReviewsAlertPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsProvider>(builder: (context, provider, child) {
      return Container(
        color: Colorss.background,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(
                color: Colorss.textColor,
                height: 5,
                endIndent: 150,
                indent: 150,
                thickness: 3,
              ),
            ),
            Expanded(
              child: ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: (provider.review ?? [])
                      .map((e) => ReviewWidget(
                          avatar: e.avatar ?? "",
                          userName: e.userName ?? "",
                          nickName: e.nickName,
                          rating: e.rating ?? 0,
                          content: e.content,
                          createdAt: e.createdAt))
                      .toList()),
            ),
          ],
        ),
      );
    });
  }
}
