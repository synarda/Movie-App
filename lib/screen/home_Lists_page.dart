import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/home_List.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        const SizedBox(height: 16),
        dividerTitle("Popular"),
        const Divider(
          color: Colorss.background,
          endIndent: 16,
          indent: 16,
          thickness: 2,
        ),
        const HomeListWidget(data: "popular", key: PageStorageKey("popular")),
        dividerTitle("Upcoming"),
        const Divider(
          color: Colorss.background,
          endIndent: 16,
          indent: 16,
          thickness: 2,
        ),
        const HomeListWidget(data: "upcoming", key: PageStorageKey("upcoming")),
        dividerTitle("Top Rated"),
        const Divider(
          color: Colorss.background,
          endIndent: 16,
          indent: 16,
          thickness: 2,
        ),
        const HomeListWidget(data: "top_rated", key: PageStorageKey("top_rated")),
        const SizedBox(height: 54),
      ],
    );
  }
}

Widget dividerTitle(str) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
        margin: const EdgeInsets.only(left: 18, top: 32),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colorss.background,
        ),
        child: Text(
          str,
          style: const TextStyle(color: Colorss.textColor, fontSize: 10),
        )),
  );
}
