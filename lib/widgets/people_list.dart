// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/models/people_model.dart';
import 'package:provider_api/providers/people_detail_provider.dart';
import 'package:provider_api/screen/people_detail_page.dart';
import 'package:provider_api/utils/const.dart';

class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({
    Key? key,
    required this.e,
    this.isGame = false,
  }) : super(key: key);
  final PeopleModel e;
  final bool isGame;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGame == false) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => PeopleDetailProviderr(e.id),
                    child: PeopleDetailPage(
                      isGame: isGame == true ? false : true,
                    )),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => PeopleDetailProviderr(e.id),
                    child: PeopleDetailPage(
                      isGame: isGame == true ? false : true,
                    )),
              ));
        }
      },
      child: Container(
        height: 220,
        width: 115,
        margin: const EdgeInsets.only(left: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          SizedBox(
            height: 218,
            width: 115,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "https://image.tmdb.org/t/p/original/${e.profilePath}",
                progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Container(
            height: 200,
            width: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colorss.background,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Text(
                e.name,
                style: const TextStyle(color: Colorss.textColor, fontSize: 10),
              ))
        ]),
      ),
    );
  }
}
