import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/providers/game_result_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/home_Lists_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/row.dart';

class GameResultPage extends StatelessWidget {
  const GameResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerGame = context.read<GameAlertProvider>();
    final provider = context.read<GameResultProvider>();

    return Scaffold(
      backgroundColor: Colorss.forebackground,
      appBar: AppBar(
        backgroundColor: Colorss.background,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: const Text("Congratulations "),
        centerTitle: true,
      ),
      body: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset("assets/success.json")),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorss.background.withOpacity(0.5),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colorss.background.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colorss.textColor),
                          borderRadius: BorderRadius.circular(20),
                          color: provider.txtColor),
                      child: Center(
                        child: Text(
                          provider.txt,
                          style: const TextStyle(color: Colorss.background),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 64),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.forebackground),
                    child: Column(children: [
                      Text(
                        context.read<LoginProvider>().account.userName,
                        style: const TextStyle(color: Colorss.textColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 64, top: 32),
                        child: RowWidget(
                            titleSize: 15,
                            padding: 8,
                            data: {"page count:   ": providerGame.countPage, "Time:   ": providerGame.testTime}),
                      ),
                    ]),
                  ),
                  dividerTitle("Routes"),
                  const Divider(
                    color: Colorss.textColor,
                    endIndent: 16,
                    indent: 16,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      children: providerGame.routeList
                          .map(
                            (e) => Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    height: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20), color: Colorss.forebackground),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 16),
                                          height: 50,
                                          width: 66,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: "https://image.tmdb.org/t/p/original/${e["img"]}",
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  const Center(
                                                child: CupertinoActivityIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              e["name"] ?? "",
                                              textAlign: TextAlign.center,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                          width: 66,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colorss.textColor,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colorss.forebackground,
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: Colorss.themeFirst)),
              child: const Icon(Icons.arrow_forward_ios_rounded)),
          onPressed: () => Navigator.pop(context)),
    );
  }
}
