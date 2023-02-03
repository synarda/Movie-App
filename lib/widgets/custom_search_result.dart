// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';

class CustomSearchResultContainer extends StatelessWidget {
  const CustomSearchResultContainer({
    Key? key,
    required this.title,
    required this.id,
    required this.imgUrl,
    required this.data,
    required this.adult,
    required this.accountId,
    required this.voteAverage,
  }) : super(key: key);
  final String title;
  final int id;
  final String imgUrl;
  final String data;
  final bool adult;
  final String accountId;
  final double voteAverage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (ctx) => DetailProvider(id),
                      child: DetailPage(
                        imgUrl: imgUrl,
                        id: id,
                        data: data,
                        adult: adult,
                        accountId: Provider.of<LoginProvider>(context).account.id,
                      ),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(children: [
          Hero(
            tag: id.toString() + data,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 5),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imgUrl.isEmpty
                    ? Image.asset("assets/noimage.png")
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "https://image.tmdb.org/t/p/original/$imgUrl",
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
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
                margin: const EdgeInsets.only(top: 10, right: 16),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            title,
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
                            percent: voteAverage / 10,
                            animation: false,
                            center: Text(
                              voteAverage.toString().substring(0, 3),
                              style: const TextStyle(color: Colorss.textColor, fontSize: 10),
                            ),
                            progressColor: Colorss.themeFirst,
                            backgroundColor: Colorss.textColor.withOpacity(0.5),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
          adult == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: Colorss.background),
                        margin: const EdgeInsets.only(right: 16),
                        child: Image.asset("assets/+18.png")),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
