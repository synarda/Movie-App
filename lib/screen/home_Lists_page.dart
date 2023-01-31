import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_List.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        const ListHome(data: "popular"),
        dividerTitle("Upcoming"),
        const Divider(
          color: Colorss.background,
          endIndent: 16,
          indent: 16,
          thickness: 2,
        ),
        const ListHome(data: "upcoming"),
        dividerTitle("Top Rated"),
        const Divider(
          color: Colorss.background,
          endIndent: 16,
          indent: 16,
          thickness: 2,
        ),
        const ListHome(data: "top_rated"),
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
