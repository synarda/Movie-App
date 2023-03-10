import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/account_provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/screen/account_page.dart';
import 'package:provider_api/screen/enddrawer_page.dart';
import 'package:provider_api/screen/home_Lists_page.dart';
import 'package:provider_api/screen/lists_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/search_result.dart';
import 'package:provider_api/widgets/textfield.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoutePageProvider>();
    final providerHome = context.watch<HomeProvider>();

    return GestureDetector(
        onTap: provider.focusNode.unfocus,
        child: Scaffold(
            endDrawer: const EndDrawerPage(),
            backgroundColor: Colorss.forebackground,
            appBar: AppBar(
              actions: [
                Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Stack(
                        children: [
                          providerHome.chooseGenreList.isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.themeFirst),
                                  child: Text(
                                    providerHome.chooseGenreList.length.toString(),
                                    style: const TextStyle(color: Colorss.textColor, fontSize: 8),
                                  ),
                                )
                              : Container(),
                          Container(margin: const EdgeInsets.all(8), child: const Icon(Icons.filter_list)),
                        ],
                      ),
                    ),
                  );
                })
              ],
              toolbarHeight: 80,
              backgroundColor: Colorss.background,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () => provider.searchAnimated(context), icon: const Icon(Icons.search)),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 1 - provider.moviesTxtOpacity,
                        child: AnimatedContainer(
                            height: 65,
                            duration: const Duration(milliseconds: 500),
                            width: provider.searchAnimWidth,
                            child: TextfieldWidget(
                              focusNode: provider.focusNode,
                              focus: false,
                              suffixIconFunc: provider.searchController.clear,
                              icon: const Icon(Icons.clear, color: Colorss.textColor),
                              label: "Search",
                              limit: 50,
                              obscure: false,
                              controller: provider.searchController,
                            )),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 24, left: 20),
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
                        ? providerHome.chooseGenreList.isNotEmpty
                            ? ListView(
                                shrinkWrap: true,
                                children: providerHome.chooseGenreListFilter
                                    .map((e) => SearchResultWidget(
                                          voteAverage: e.voteAverage,
                                          title: e.title,
                                          imgUrl: e.imgUrl,
                                          id: e.id,
                                          data: "",
                                          adult: e.adult,
                                          accountId: Provider.of<LoginProvider>(context).account.id,
                                        ))
                                    .toList(),
                              )
                            : ChangeNotifierProvider(
                                key: const PageStorageKey<String>("home"),
                                create: (_) => HomeProvider(),
                                child: const HomePage())
                        : ChangeNotifierProvider(
                            key: const PageStorageKey<String>("route"),
                            create: (_) => RoutePageProvider(),
                            child: ListView(
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              children: provider.searchResList
                                  .map((e) => SearchResultWidget(
                                        voteAverage: e.voteAverage,
                                        title: e.title,
                                        imgUrl: e.imgUrl,
                                        id: e.id,
                                        data: "",
                                        adult: e.adult,
                                        accountId: Provider.of<LoginProvider>(context).account.id,
                                      ))
                                  .toList(),
                            ),
                          ),
                    Consumer<LoginProvider>(builder: ((context, loginProvider, child) {
                      return loginProvider.isLoading
                          ? const Center(child: CupertinoActivityIndicator())
                          : ChangeNotifierProvider(
                              key: const PageStorageKey<String>("lists"),
                              create: (_) => ListsProvider(loginProvider.account.id),
                              child: const ListsPage());
                    })),
                    Consumer<LoginProvider>(builder: ((context, loginProvider, child) {
                      return loginProvider.isLoading
                          ? const Center(child: CupertinoActivityIndicator())
                          : ChangeNotifierProvider(
                              key: const PageStorageKey<String>("account"),
                              create: (_) => AccountProvider(),
                              child: AccountPage(accountId: loginProvider.account.id),
                            );
                    })),
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
                    items: <Widget>[
                      Icon(Icons.home, size: 30, color: Colorss.themeFirst),
                      Icon(Icons.add, size: 30, color: Colorss.themeFirst),
                      Icon(Icons.person, size: 30, color: Colorss.themeFirst),
                    ],
                    onTap: (index) {
                      provider.controller
                          .animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
                    },
                  ),
                ),
              ],
            )));
  }
}
