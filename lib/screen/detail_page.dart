// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_movie_provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/reviews_provider.dart';
import 'package:provider_api/screen/alerts/addMovie_alert_page.dart';
import 'package:provider_api/screen/alerts/put_rating_alert.dart';
import 'package:provider_api/screen/alerts/reviews_alert.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_row.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.imgUrl,
    required this.id,
    required this.data,
    required this.adult,
    required this.accountId,
  }) : super(key: key);
  final String? imgUrl;

  final int id;
  final String data;
  final bool adult;
  final String accountId;

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
    return Scaffold(
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
            child: Consumer<DetailProvider>(builder: (context, provider, child) {
              return SingleChildScrollView(
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
                                                      errorWidget: (context, url, error) =>
                                                          const Icon(
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
                                                      style:
                                                          const TextStyle(color: Colorss.textColor),
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
                                                physics: const BouncingScrollPhysics(
                                                    parent: AlwaysScrollableScrollPhysics()),
                                                scrollDirection: Axis.horizontal,
                                                children: provider.movie!.genres!
                                                    .map((x) => Container(
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colorss.forebackground
                                                                      .withOpacity(0.5),
                                                                  spreadRadius: 1,
                                                                  blurRadius: 10,
                                                                  offset: const Offset(0, 5),
                                                                ),
                                                              ],
                                                              color: Colorss.background,
                                                              borderRadius:
                                                                  BorderRadius.circular(20)),
                                                          margin: const EdgeInsets.only(
                                                              left: 0, right: 8, top: 8, bottom: 8),
                                                          padding: const EdgeInsets.all(5),
                                                          child: Text(
                                                            x["name"].toString(),
                                                            style: const TextStyle(
                                                                color: Colorss.themeFirst,
                                                                fontSize: 8),
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8, left: 16, bottom: 8),
                                    child: GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (x) => MultiProvider(
                                                providers: [
                                                  ChangeNotifierProvider<ListsProvider>(
                                                      create: (ctx) =>
                                                          ListsProvider(widget.accountId)),
                                                  ChangeNotifierProvider<AddMovieProvider>(
                                                      create: (ctx) => AddMovieProvider())
                                                ],
                                                child: AddMovieAlertPage(
                                                  accounId: widget.accountId,
                                                  movieId: widget.id,
                                                ),
                                              )),
                                      child: Container(
                                        height: 28,
                                        width: 100,
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
                                            color: Colorss.background),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text(
                                              "Add Watch list",
                                              style:
                                                  TextStyle(color: Colorss.textColor, fontSize: 8),
                                            ),
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              color: Colorss.textColor,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (x) => const PutRatingAlert()).then((value) {
                                          if (value != null) {
                                            context.read<GlobalProvider>().postRating(
                                                provider.movie!.id, value * 2, provider.movie!);
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 70,
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
                                            color: Colorss.background),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Rate",
                                              style:
                                                  TextStyle(color: Colorss.textColor, fontSize: 8),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.star,
                                              color: Colorss.textColor,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (x) => ChangeNotifierProvider(
                                            create: (ctx) => ReviewsProvider(widget.id),
                                            child: const ReviewsAlertPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 90,
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
                                            color: Colorss.background),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "comments",
                                              style:
                                                  TextStyle(color: Colorss.textColor, fontSize: 8),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.comment,
                                              color: Colorss.textColor,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
                                        color: context
                                                .watch<GlobalProvider>()
                                                .isFavorite(provider.movie!.id)
                                            ? Colorss.themeFirst
                                            : Colorss.forebackground),
                                    child: context
                                            .read<GlobalProvider>()
                                            .isFavorite(provider.movie!.id)
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
                                                : CustomRow(data: {
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
                                                  provider.movie!.voteAverage
                                                      .toString()
                                                      .substring(0, 3),
                                                  style: const TextStyle(color: Colorss.textColor),
                                                ),
                                                progressColor: Colorss.themeFirst,
                                              ),
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 64),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text(
                                      "Similar Movie's",
                                      style: TextStyle(color: Colorss.textColor),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                    width: double.infinity,
                                    child: Consumer<DetailProvider>(
                                      builder: (context, provider, child) {
                                        return GridView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                          ),
                                          itemCount: provider.similarList.length,
                                          itemBuilder: (context, index) {
                                            final e = provider.similarList[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                              create: (ctx) => DetailProvider(e.id,
                                                                  context.read<GlobalProvider>()),
                                                              child: DetailPage(
                                                                  adult: e.adult,
                                                                  data: widget.data,
                                                                  id: e.id,
                                                                  imgUrl: e.imgUrl,
                                                                  accountId:
                                                                      Provider.of<LoginProvider>(
                                                                              context)
                                                                          .account
                                                                          .id),
                                                            )));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20)),
                                                height: 150,
                                                width: MediaQuery.of(context).size.width / 3,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.all(16),
                                                      height: 100,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: e.imgUrl.isEmpty
                                                            ? Center(
                                                                child: SizedBox(
                                                                    height: 30,
                                                                    width: 30,
                                                                    child: Image.asset(
                                                                        "assets/noimage.png")),
                                                              )
                                                            : CachedNetworkImage(
                                                                fit: BoxFit.cover,
                                                                imageUrl:
                                                                    "https://image.tmdb.org/t/p/original/${e.imgUrl}",
                                                                errorWidget:
                                                                    (context, url, error) =>
                                                                        const Icon(Icons.error),
                                                              ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.all(13),
                                                      decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            begin: Alignment.bottomCenter,
                                                            end: Alignment.topCenter,
                                                            colors: [
                                                              Colorss.background,
                                                              Colors.transparent,
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.circular(20)),
                                                      child: Align(
                                                        alignment: Alignment.bottomCenter,
                                                        child: Text(
                                                          e.title,
                                                          style: const TextStyle(
                                                              color: Colorss.textColor,
                                                              fontSize: 8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ]));
            }),
          ),
          Padding(
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
    );
  }
}

class Blur extends StatelessWidget {
  const Blur({
    Key? key,
    required this.child,
    this.overlay,
    this.blur = 5,
  }) : super(key: key);

  final Widget child;
  final Widget? overlay;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colorss.background.withOpacity(0.5),
                ),
                child: overlay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
