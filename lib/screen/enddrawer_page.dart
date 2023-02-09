import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/utils/const.dart';

class EndDrawerPage extends StatelessWidget {
  const EndDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Scaffold(
        backgroundColor: Colorss.background,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              color: Colorss.forebackground,
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Text(
                "Filter",
                style: TextStyle(color: Colorss.textColor, fontSize: 14),
              )),
            ),
            Container(
                color: Colorss.background,
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: provider.chooseGenreList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: provider.chooseGenreList
                                .map((e) => GestureDetector(
                                      onTap: () => provider.chooseGenre(e, 11),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            height: 70,
                                            width: 70,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.asset(
                                                "assets/$e.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.transparent),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              e,
                                              style: const TextStyle(
                                                  color: Colorss.textColor, fontSize: 9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList()),
                      )
                    : Lottie.asset("assets/ghostt.json")),
            Expanded(
              child: GridView.count(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  crossAxisCount: 2,
                  children: provider.genresList.map((e) {
                    final contain = provider.chooseGenreList.contains(e!.genre);
                    return GestureDetector(
                      onTap: () {
                        provider.chooseGenre(e.genre, e.id);
                        provider.fetchGenreFilter(
                            context.read<LoginProvider>().account.id, provider.chooseGenreListInt);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.all(contain ? provider.animPadding : 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: contain ? Colorss.themeFirst : Colorss.forebackground),
                            color: Colorss.forebackground,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colorss.forebackground.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            height: 40,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                e.genre,
                                style: const TextStyle(color: Colorss.textColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
