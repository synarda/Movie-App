// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/reviews_provider.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/review_widget.dart';
import 'package:provider_api/widgets/textfield.dart';

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
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Flexible(
                      flex: 4,
                      child: TextfieldWidget(label: "comment", limit: 200, obscure: false)),
                  Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colorss.themeFirst,
                            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        child: const Text("Send"),
                      ))
                ],
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
