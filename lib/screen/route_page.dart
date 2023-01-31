import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/account_provider.dart';
import 'package:provider_api/providers/add_provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/navigate_provider.dart';
import 'package:provider_api/screen/account_page.dart';
import 'package:provider_api/screen/home_Lists_page.dart';
import 'package:provider_api/screen/lists_page.dart';
import 'package:provider_api/utils/const.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colorss.forebackground,
        appBar: AppBar(
          backgroundColor: Colorss.background,
          title: const Text(
            "Movie's",
            style: TextStyle(color: Colorss.textColor),
          ),
          centerTitle: true,
        ),
        body: Consumer<NavigateProvider>(builder: (context, provider, child) {
          final loginProvider = context.read<LoginProvider>();
          return Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: provider.controller,
                onPageChanged: (value) {
                  provider.pageIdx = value;
                },
                children: [
                  ChangeNotifierProvider(
                    create: (_) => HomeProvider(),
                    child: const HomePage(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AddProvider(loginProvider.accountId),
                    child: const ListsPage(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => AccountProvider(),
                    child: const AccountPage(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CurvedNavigationBar(
                  index: provider.pageIdx,
                  animationDuration: const Duration(milliseconds: 400),
                  height: 60,
                  backgroundColor: Colors.transparent,
                  color: Colorss.background,
                  buttonBackgroundColor: Colorss.background,
                  items: const <Widget>[
                    Icon(Icons.home, size: 30, color: Colorss.themeFirst),
                    Icon(Icons.add, size: 30, color: Colorss.themeFirst),
                    Icon(Icons.person, size: 30, color: Colorss.themeFirst),
                  ],
                  onTap: (index) {
                    provider.controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
                  },
                ),
              ),
            ],
          );
        }));
  }
}
