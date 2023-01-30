import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_List.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colorss.background,
        appBar: AppBar(
          backgroundColor: Colorss.background,
          title: const Text(
            "Movie's",
            style: TextStyle(color: Colorss.textColor),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView(
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                animationDuration: const Duration(milliseconds: 400),
                height: 60,
                backgroundColor: Colors.transparent,
                color: Colorss.background,
                buttonBackgroundColor: Colorss.background,
                items: const <Widget>[
                  Icon(Icons.add, size: 30, color: Colorss.themeFirst),
                  Icon(Icons.list, size: 30, color: Colorss.themeFirst),
                  Icon(Icons.compare_arrows, size: 30, color: Colorss.themeFirst),
                ],
                onTap: (index) {},
              ),
            ),
          ],
        ));
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
