import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/screen/detail.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/shimmer.dart';

class ListHome extends StatelessWidget {
  const ListHome({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: 225,
        child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: provider.homeLists[data]!.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (ctx) => DetailProvider(e.id),
                                child: DetailPage(
                                  imgUrl: e.imgUrl,
                                  id: e.id,
                                  data: data,
                                  adult: e.adult,
                                ),
                              )));
                },
                child: Stack(children: [
                  Hero(
                    tag: e.id.toString() + data,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: 300,
                      width: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "https://image.tmdb.org/t/p/original/${e.imgUrl}",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              ShimmerWrapper(
                            active: true,
                            child: Container(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
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
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(left: 16),
                      height: 200,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 105),
                              Text(
                                e.title,
                                style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 250,
                                height: 35,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  scrollDirection: Axis.horizontal,
                                  children: e.genres
                                      .map((x) => Container(
                                            decoration: BoxDecoration(
                                                color: Colorss.themeFirst,
                                                borderRadius: BorderRadius.circular(20)),
                                            margin: const EdgeInsets.only(
                                                left: 0, right: 8, top: 8, bottom: 8),
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              provider.genresList[x].toString(),
                                              style: const TextStyle(
                                                  color: Colorss.textColor, fontSize: 8),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  e.adult == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colorss.background),
                                margin: const EdgeInsets.only(right: 16),
                                child: Image.asset("assets/+18.png")),
                          ),
                        )
                      : Container(),
                ]),
              );
            }).toList()),
      );
    });
  }
}
