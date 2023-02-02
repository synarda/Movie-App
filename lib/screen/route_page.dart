import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/account_provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/screen/account_page.dart';
import 'package:provider_api/screen/home_Lists_page.dart';
import 'package:provider_api/screen/lists_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_search_result.dart';
import 'package:provider_api/widgets/custom_textfield.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoutePageProvider>(builder: (context, provider, child) {
      final loginProvider = context.read<LoginProvider>();
      return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              backgroundColor: Colorss.forebackground,
              appBar: AppBar(
                toolbarHeight: 80,
                backgroundColor: Colorss.background,
                title: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => provider.searchAnimated(),
                            icon: const Icon(Icons.search)),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: 1 - provider.moviesTxtOpacity,
                          child: AnimatedContainer(
                              height: 45,
                              duration: const Duration(milliseconds: 500),
                              width: provider.searchAnimWidth,
                              child: CustomTextField(
                                suffixIconFunc: provider.searchController.clear,
                                icon: const Icon(Icons.clear, color: Colorss.textColor),
                                label: "Search",
                                limit: 50,
                                obscure: false,
                                controller: provider.searchController,
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 50),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: provider.moviesTxtOpacity,
                        child: const Text(
                          "Movie's",
                          style: TextStyle(color: Colorss.textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: provider.controller,
                    onPageChanged: (value) {
                      provider.pageIdx = value;
                    },
                    children: [
                      provider.searchController.text.isEmpty
                          ? ChangeNotifierProvider(
                              key: const PageStorageKey<String>("home"),
                              create: (_) => HomeProvider(),
                              child: const HomePage())
                          : ChangeNotifierProvider(
                              key: const PageStorageKey<String>("route"),
                              create: (_) => RoutePageProvider(),
                              child: ListView(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                children: provider.searchResList
                                    .map((e) => CustomSearchResultContainer(
                                          voteAverage: e.voteAverage,
                                          title: e.title,
                                          imgUrl: e.imgUrl,
                                          id: e.id,
                                          data: "",
                                          adult: e.adult,
                                          accountId: Provider.of<LoginProvider>(context).accountId,
                                        ))
                                    .toList(),
                              ),
                            ),
                      ChangeNotifierProvider(
                          key: const PageStorageKey<String>("lists"),
                          create: (_) => AddProvider(loginProvider.accountId),
                          child: const ListsPage()),
                      ChangeNotifierProvider(
                        key: const PageStorageKey<String>("account"),
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
              )));
    });
  }
}
