import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/alerts/delete_alert_page.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/animated_listview.dart';
import 'package:provider_api/widgets/row.dart';

class RatedMoviesPage extends StatelessWidget {
  const RatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      appBar: AppBar(
        backgroundColor: Colorss.background,
        title: const Text("Rated Movie's"),
        centerTitle: true,
      ),
      body: Consumer<GlobalProvider>(builder: (context, provider, child) {
        return provider.ratedList.isEmpty
            ? Center(
                child: SizedBox(height: 250, width: 500, child: Lottie.asset("assets/ghostt.json")))
            : AnimatedListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: provider.ratedList
                    .map((x) => GestureDetector(
                          key: ValueKey(x.hashCode),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ChangeNotifierProvider(
                                  create: (ctx) =>
                                      DetailProvider(x.id, context.read<GlobalProvider>()),
                                  child: DetailPage(
                                    imgUrl: x.backdropPath,
                                    id: x.id,
                                    data: "",
                                    adult: false,
                                    accountId: Provider.of<LoginProvider>(context).account.id,
                                  ),
                                );
                              },
                            ));
                          },
                          child: Container(
                              width: double.infinity,
                              height: 180,
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colorss.background),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original/${x.backdropPath}",
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) => const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    trailing: CircularPercentIndicator(
                                      animationDuration: 1500,
                                      radius: 20.0,
                                      lineWidth: 5.0,
                                      percent: x.voteAverage / 10,
                                      animation: true,
                                      center: Text(
                                        x.rate.toString().substring(0, 3),
                                        style: const TextStyle(color: Colorss.textColor),
                                      ),
                                      progressColor: Colorss.themeFirst,
                                    ),
                                    title: Text(
                                      x.title,
                                      style:
                                          const TextStyle(color: Colorss.textColor, fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RowWidget(
                                          data: {
                                            "vote count : ": x.voteCount,
                                            "popularity : ": x.popularity,
                                            "your vote : ": x.rate == null ? 0 : x.rate! / 10.0,
                                          },
                                          padding: 4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: IconButton(
                                              onPressed: () async {
                                                final result = await showDialog(
                                                    context: context,
                                                    builder: (context) => const DeleteAlertPage());
                                                if (result == true) {
                                                  provider.deleteRate(x.id, x);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colorss.themeFirst,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ))
                    .toList());
      }),
    );
  }
}
