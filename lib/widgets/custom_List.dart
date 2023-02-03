import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';

class ListHome extends StatelessWidget {
  const ListHome({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        return ListView(
            key: PageStorageKey(data),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
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
                                  accountId: Provider.of<LoginProvider>(context).account.id,
                                ),
                              )));
                },
                child: Stack(children: [
                  Hero(
                    tag: e.id.toString() + data,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
                      height: 300,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "https://image.tmdb.org/t/p/original/${e.imgUrl}",
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
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  e.title,
                                  style: const TextStyle(
                                      color: Colorss.textColor,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: CircularPercentIndicator(
                                  animationDuration: 1500,
                                  radius: 15.0,
                                  lineWidth: 3.0,
                                  percent: e.voteAverage / 10,
                                  animation: false,
                                  center: Text(
                                    e.voteAverage.toString().substring(0, 3),
                                    style: const TextStyle(color: Colorss.textColor, fontSize: 10),
                                  ),
                                  progressColor: Colorss.themeFirst,
                                  backgroundColor: Colorss.textColor.withOpacity(0.5),
                                ),
                              )
                              /*SizedBox(
                                width: 250,
                                height: 35,
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                              ),*/
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
            }).toList());
      }),
    );
  }
}
