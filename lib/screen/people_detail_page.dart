// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/providers/people_detail_provider.dart';
import 'package:provider_api/screen/home_Lists_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/utils/extentions.dart';
import 'package:provider_api/widgets/people_detail_credits.dart';
import 'package:provider_api/widgets/row.dart';

class PeopleDetailPage extends StatelessWidget {
  const PeopleDetailPage({
    Key? key,
    this.isGame = false,
  }) : super(key: key);
  final bool isGame;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PeopleDetailProvider>();
    final people = provider.personDetail;
    final providerAlert = context.read<GameAlertProvider>();
    providerAlert.contextt = context;

    return WillPopScope(
        onWillPop: () async {
          provider.inGameWillPop(context, isGame);
          return false;
        },
        child: Scaffold(
            appBar: isGame == true
                ? AppBar(
                    leading: const SizedBox(),
                    leadingWidth: 0,
                    toolbarHeight: 80,
                    backgroundColor: Colorss.background,
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 4),
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: "https://image.tmdb.org/t/p/original/${providerAlert.gameModel?.from.poster}",
                                progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              providerAlert.gameModel!.from.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8)
                        ],
                      ),
                      Column(
                        children: [
                          Text(context.watch<GameAlertProvider>().testTime.secondsToTimeZero),
                          const Icon(Icons.arrow_forward, color: Colorss.textColor, size: 15),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 4),
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: "https://image.tmdb.org/t/p/original/${providerAlert.gameModel?.to.poster}",
                                progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              providerAlert.gameModel!.to.name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 8)
                        ],
                      ),
                    ]),
                    centerTitle: true,
                  )
                : null,
            backgroundColor: Colorss.background,
            body: provider.personDetail == null
                ? const SizedBox()
                : Stack(
                    children: [
                      ListView(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "https://image.tmdb.org/t/p/original/${people!.profilePath}",
                                  progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              Positioned.fill(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      color: Colorss.background.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 1,
                                child: ListView(
                                  shrinkWrap: false,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 64, bottom: 32, left: 64),
                                            height: 170,
                                            width: 100,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: people.profilePath == null
                                                    ? Image.asset("assets/noimage.png")
                                                    : CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://image.tmdb.org/t/p/original/${people.profilePath}",
                                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                            const Center(
                                                          child: CupertinoActivityIndicator(),
                                                        ),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                      )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 24, left: 32),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(provider.personDetail!.name,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colorss.textColor,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20)),
                                                ),
                                                const SizedBox(height: 32),
                                                RowWidget(
                                                  contentSize: 10,
                                                  padding: 3,
                                                  data: {
                                                    "birthday:  ": people.birthday ?? "no data",
                                                    "deathday:  ": people.deathday ?? "∞",
                                                    "Place of Birth  :  ": people.placeOfBirt ?? "no data",
                                                    "Gender  :  ": people.gender == 1 ? "Female" : "Male"
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    dividerTitle("Biography"),
                                    const Divider(
                                      color: Colorss.textColor,
                                      endIndent: 16,
                                      indent: 16,
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                        padding: const EdgeInsets.only(left: 16, right: 16),
                                        height: 248,
                                        child: Stack(
                                          children: [
                                            ListView(
                                              physics:
                                                  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                              children: [
                                                Text(
                                                  people.biography ?? "No  biography",
                                                  style: const TextStyle(color: Colorss.textColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    const SizedBox(height: 16),
                                    dividerTitle("Movie's"),
                                    const Divider(
                                      color: Colorss.textColor,
                                      endIndent: 16,
                                      indent: 16,
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(height: 16),
                                    PeopleDetailCreditsMovies(
                                      data: "",
                                      isGame: isGame == true ? false : true,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isGame == true
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 32, left: 16),
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colorss.textColor,
                                    ),
                                    onPressed: () => Navigator.pop(context)),
                              ),
                            ),
                    ],
                  )));
  }
}
