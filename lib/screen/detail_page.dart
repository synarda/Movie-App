// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_movie_provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/alerts/addMovie_alert_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_row.dart';
import 'package:provider_api/widgets/shimmer.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.imgUrl,
    required this.id,
    required this.data,
    required this.adult,
    required this.accountId,
  }) : super(key: key);
  final String imgUrl;

  final int id;
  final String data;
  final bool adult;
  final String accountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.background,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Hero(
                  tag: id.toString() + data.toString(),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "https://image.tmdb.org/t/p/original/$imgUrl",
                    progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<DetailProvider>(builder: (context, provider, child) {
                  return NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: provider.movieList
                            .map(
                              (movie) => Column(
                                children: [
                                  Stack(
                                    children: [
                                      AnimatedOpacity(
                                        duration: const Duration(milliseconds: 500),
                                        opacity: provider.opacity,
                                        child: Container(
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
                                                          color:
                                                              Colorss.background.withOpacity(0.8),
                                                          spreadRadius: 1,
                                                          blurRadius: 10,
                                                          offset: const Offset(0, 5),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                                                        progressIndicatorBuilder:
                                                            (context, url, downloadProgress) =>
                                                                ShimmerWrapper(
                                                          active: true,
                                                          child: Container(),
                                                        ),
                                                        errorWidget: (context, url, error) =>
                                                            const Icon(Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: 66, right: 16),
                                                      child: Text(
                                                        textAlign: TextAlign.center,
                                                        movie.title,
                                                        style: const TextStyle(
                                                            color: Colorss.textColor),
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
                                                            parent:
                                                                AlwaysScrollableScrollPhysics()),
                                                        scrollDirection: Axis.horizontal,
                                                        children: movie.genres
                                                            .map((x) => Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colorss
                                                                              .forebackground
                                                                              .withOpacity(0.5),
                                                                          spreadRadius: 1,
                                                                          blurRadius: 10,
                                                                          offset:
                                                                              const Offset(0, 5),
                                                                        ),
                                                                      ],
                                                                      color: Colorss.background,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  margin: const EdgeInsets.only(
                                                                      left: 0,
                                                                      right: 8,
                                                                      top: 8,
                                                                      bottom: 8),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(
                                          parent: AlwaysScrollableScrollPhysics()),
                                      children: [
                                        Text(
                                          movie.description,
                                          style: const TextStyle(
                                              color: Colorss.textColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8, left: 16, bottom: 64),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () => showDialog(
                                            context: context,
                                            builder: (x) => MultiProvider(
                                                  providers: [
                                                    ChangeNotifierProvider<AddProvider>(
                                                        create: (ctx) => AddProvider(accountId)),
                                                    ChangeNotifierProvider<AddMovieProvider>(
                                                        create: (ctx) => AddMovieProvider())
                                                  ],
                                                  child: AddMovieAlertPage(
                                                    accounId: accountId,
                                                    movieId: id,
                                                  ),
                                                )),
                                        child: Container(
                                          height: 28,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colorss.forebackground.withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colorss.themeFirst),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: const [
                                              Text(
                                                "Add list",
                                                style: TextStyle(
                                                    color: Colorss.textColor, fontSize: 8),
                                              ),
                                              Icon(
                                                Icons.star_border,
                                                color: Colorss.textColor,
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colorss.background,
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 12, left: 12, bottom: 12),
                                    width: double.infinity,
                                    height: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 16),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomRow(
                                                  title: "Release date:  ",
                                                  data: movie.releaseDate),
                                              CustomRow(title: "Status:  ", data: movie.status),
                                              CustomRow(
                                                  title: "Revenue:  ",
                                                  data: movie.revenue.toString()),
                                              CustomRow(
                                                  title: "Budget:  ",
                                                  data: movie.budget.toString()),
                                              CustomRow(
                                                  title: "Popularity:  ",
                                                  data: movie.popularity.toString()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 64),
                                          child: CircularPercentIndicator(
                                            animationDuration: 1500,
                                            radius: 30.0,
                                            lineWidth: 5.0,
                                            percent: movie.voteAverage / 10,
                                            animation: true,
                                            center: Text(
                                              movie.voteAverage.toString().substring(0, 3),
                                              style: const TextStyle(color: Colorss.textColor),
                                            ),
                                            progressColor: Colorss.themeFirst,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text(
                                      "Similar Movie's",
                                      style: TextStyle(color: Colorss.textColor),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    height: 400,
                                    child: Consumer<DetailProvider>(
                                      builder: (context, provider, child) {
                                        return GridView.builder(
                                          shrinkWrap: false,
                                          physics: const BouncingScrollPhysics(
                                              parent: AlwaysScrollableScrollPhysics()),
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
                                                              create: (ctx) => DetailProvider(e.id),
                                                              child: DetailPage(
                                                                  adult: e.adult,
                                                                  data: data,
                                                                  id: e.id,
                                                                  imgUrl: e.imgUrl,
                                                                  accountId:
                                                                      Provider.of<LoginProvider>(
                                                                              context)
                                                                          .accountId),
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
                                                        child: CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              "https://image.tmdb.org/t/p/original/${e.imgUrl}",
                                                          progressIndicatorBuilder:
                                                              (context, url, downloadProgress) =>
                                                                  //TODO: shimmer add
                                                                  ShimmerWrapper(
                                                            active: true,
                                                            child: Container(),
                                                          ),
                                                          errorWidget: (context, url, error) =>
                                                              const Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            gradient: const LinearGradient(
                                                              begin: Alignment.bottomCenter,
                                                              end: Alignment.topCenter,
                                                              colors: [
                                                                Colorss.background,
                                                                Colors.transparent,
                                                              ],
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(20)),
                                                        height: 100,
                                                        width:
                                                            MediaQuery.of(context).size.width / 3,
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
                              ),
                            )
                            .toList(),
                      ));
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
        ]),
      ),
    );
  }
}
