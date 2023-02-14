import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_movie_provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/reviews_provider.dart';
import 'package:provider_api/screen/alerts/addMovie_alert_page.dart';
import 'package:provider_api/screen/alerts/put_rating_alert.dart';
import 'package:provider_api/screen/alerts/reviews_alert.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/utils/extentions.dart';
import 'package:provider_api/widgets/blur.dart';
import 'package:provider_api/widgets/button.dart';
import 'package:provider_api/widgets/people_list.dart';
import 'package:provider_api/widgets/row.dart';
import 'package:provider_api/widgets/similar_movie.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.imgUrl,
    required this.id,
    required this.data,
    required this.adult,
    required this.accountId,
    this.isGame = false,
  }) : super(key: key);
  final String? imgUrl;

  final int id;
  final String data;
  final bool adult;
  final String accountId;
  final bool isGame;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final scrollController = ScrollController();
  final blur = ValueNotifier<double>(0.0);
  final blurOpacity = ValueNotifier<double>(1.0);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(
      () {
        final blr = max(scrollController.position.pixels / 50, 0.0);
        final blrOpacity = 1.0 - min(max(scrollController.position.pixels / 100, 0.0), 1.0);

        if (blr < 5) blur.value = blr;
        if (blrOpacity > 0) blurOpacity.value = blrOpacity;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailProvider>();
    final providerAlert = context.read<GameAlertProvider>();
    return WillPopScope(
      onWillPop: () async {
        provider.inGameWillPop(context, widget.isGame);
        return false;
      },
      child: Scaffold(
        appBar: widget.isGame == true
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
        body: Stack(
          children: [
            ValueListenableBuilder(
                valueListenable: blur,
                child: Hero(
                  tag: widget.id.toString() + widget.data.toString(),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 298,
                        width: 497,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "https://image.tmdb.org/t/p/original/${widget.imgUrl}",
                          progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: 500,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colorss.background,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                builder: (context, val, child) {
                  return Blur(
                    blur: val,
                    child: child!,
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: provider.movie == null
                    ? const SizedBox()
                    : Column(children: [
                        Stack(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: blurOpacity,
                                child: SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          height: 160,
                                          width: 100,
                                          margin: const EdgeInsets.only(
                                            left: 32,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colorss.background.withOpacity(0.8),
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: provider.movie!.posterPath == null
                                                ? Center(
                                                    child: SizedBox(
                                                        height: 35,
                                                        width: 35,
                                                        child: Image.asset("assets/noimage.png")),
                                                  )
                                                : CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://image.tmdb.org/t/p/original/${provider.movie!.posterPath}",
                                                    errorWidget: (context, url, error) => const Icon(
                                                      Icons.signal_cellular_nodata,
                                                      color: Colorss.textColor,
                                                      size: 25,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                          width: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 66, right: 16),
                                            child: provider.movie!.title.isEmpty
                                                ? const Text(
                                                    textAlign: TextAlign.center,
                                                    "No title",
                                                    style: TextStyle(color: Colorss.textColor),
                                                  )
                                                : Text(
                                                    textAlign: TextAlign.center,
                                                    provider.movie!.title,
                                                    style: const TextStyle(color: Colorss.textColor),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 32),
                                          child: SizedBox(
                                            width: 250,
                                            height: 35,
                                            child: ListView(
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                              scrollDirection: Axis.horizontal,
                                              children: provider.movie!.genres!
                                                  .map((x) => Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colorss.forebackground.withOpacity(0.5),
                                                                spreadRadius: 1,
                                                                blurRadius: 10,
                                                                offset: const Offset(0, 5),
                                                              ),
                                                            ],
                                                            color: Colorss.background,
                                                            borderRadius: BorderRadius.circular(20)),
                                                        margin:
                                                            const EdgeInsets.only(left: 0, right: 8, top: 8, bottom: 8),
                                                        padding: const EdgeInsets.all(5),
                                                        child: Text(
                                                          x["name"].toString(),
                                                          style: TextStyle(color: Colorss.themeFirst, fontSize: 8),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                builder: (context, val, child) {
                                  return Opacity(
                                    opacity: val,
                                    child: child!,
                                  );
                                }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            provider.movie!.description,
                            style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ButtonWidget(
                                  txt: "Add Watch list",
                                  func: () => showDialog(
                                      context: context,
                                      builder: (x) => MultiProvider(
                                            providers: [
                                              ChangeNotifierProvider<ListsProvider>(
                                                  create: (ctx) => ListsProvider(widget.accountId)),
                                              ChangeNotifierProvider<AddMovieProvider>(
                                                  create: (ctx) => AddMovieProvider())
                                            ],
                                            child: AddMovieAlertPage(
                                              accounId: widget.accountId,
                                              movieId: widget.id,
                                            ),
                                          )),
                                  widget:
                                      const Icon(Icons.add_circle_outline_sharp, color: Colorss.textColor, size: 15),
                                ),
                                ButtonWidget(
                                  txt: "Rate",
                                  func: () => showDialog(context: context, builder: (x) => const PutRatingAlert())
                                      .then((value) {
                                    if (value != null) {
                                      context
                                          .read<GlobalProvider>()
                                          .postRating(provider.movie!.id, value * 2, provider.movie!);
                                    }
                                  }),
                                  widget: const Icon(Icons.star, color: Colorss.textColor, size: 15),
                                ),
                                ButtonWidget(
                                  txt: "comments",
                                  func: () => showModalBottomSheet(
                                    context: context,
                                    builder: (x) => ChangeNotifierProvider(
                                      create: (ctx) => ReviewsProvider(widget.id),
                                      child: const ReviewsAlertPage(),
                                    ),
                                  ),
                                  widget: const Icon(
                                    Icons.comment,
                                    color: Colorss.textColor,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  final favoriteProvider = context.read<GlobalProvider>();
                                  favoriteProvider.postMarkFavorite(
                                      provider.movie!, context.read<LoginProvider>().account.id);
                                },
                                child: Container(
                                  height: 28,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colorss.themeFirst),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colorss.forebackground.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      color: context.watch<GlobalProvider>().isFavorite(provider.movie!.id)
                                          ? Colorss.themeFirst
                                          : Colorss.forebackground),
                                  child: context.read<GlobalProvider>().isFavorite(provider.movie!.id)
                                      ? const Icon(
                                          Icons.bookmark_outlined,
                                          color: Colorss.textColor,
                                          size: 15,
                                        )
                                      : const Icon(
                                          Icons.bookmark_border_rounded,
                                          color: Colorss.textColor,
                                          size: 15,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, top: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          provider.movie!.releaseDate.isEmpty
                                              ? const Text(
                                                  textAlign: TextAlign.center,
                                                  "No data",
                                                  style: TextStyle(color: Colorss.textColor),
                                                )
                                              : RowWidget(data: {
                                                  "Release date:  ": provider.movie!.releaseDate,
                                                  "Status:  ": provider.movie!.status,
                                                  "Revenue:  ": provider.movie!.revenue,
                                                  "Budget:  ": provider.movie!.budget,
                                                  "Popularity:  ": provider.movie!.popularity,
                                                })
                                        ],
                                      ),
                                    ),
                                    provider.movie!.voteAverage == 0.0
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(right: 48),
                                            child: CircularPercentIndicator(
                                              animationDuration: 1500,
                                              radius: 30.0,
                                              lineWidth: 5.0,
                                              percent: provider.movie!.voteAverage / 10,
                                              animation: true,
                                              center: Text(
                                                provider.movie!.voteAverage.toString().substring(0, 3),
                                                style: const TextStyle(color: Colorss.textColor),
                                              ),
                                              progressColor: Colorss.themeFirst,
                                            ),
                                          )
                                  ],
                                ),
                                const SizedBox(height: 32),
                                const Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text(
                                    "Cast Movie's",
                                    style: TextStyle(color: Colorss.textColor),
                                  ),
                                ),
                                Divider(
                                  color: Colorss.themeFirst,
                                  endIndent: 16,
                                  thickness: 0.3,
                                  indent: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 48,
                                    left: 16,
                                    right: 16,
                                  ),
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      scrollDirection: Axis.horizontal,
                                      children: (provider.peoples ?? [])
                                          .map((e) => PeopleListWidget(
                                                e: e,
                                                isGame: widget.isGame == true ? false : true,
                                              ))
                                          .toList()),
                                ),
                                const SizedBox(height: 32),
                                Visibility(
                                  visible: widget.isGame == true ? false : true,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text(
                                          "Similar Movie's",
                                          style: TextStyle(color: Colorss.textColor),
                                        ),
                                      ),
                                      Divider(
                                        color: Colorss.themeFirst,
                                        endIndent: 16,
                                        thickness: 0.3,
                                        indent: 16,
                                      ),
                                      SimilarMovieWidget(
                                        data: widget.data,
                                        isGame: widget.isGame == true ? false : true,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
              ),
            ),
            widget.isGame == true
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colorss.textColor,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
          ],
        ),
      ),
    );
  }
}
