import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/list_detail_provider.dart';
import 'package:provider_api/utils/const.dart';

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListDetailProvider>(builder: ((context, provider, child) {
      return Scaffold(
        backgroundColor: Colorss.forebackground,
        appBar: AppBar(
            backgroundColor: Colorss.background, centerTitle: true, title: const Text("Movie's")),
        body: Column(
            children: provider.listDetail
                .map((e) => Expanded(
                      child: ListView(
                        physics:
                            const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        children: e!.items
                            .map((x) => Container(
                                width: double.infinity,
                                height: 100,
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colorss.background),
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/original/${x["backdrop_path"]}",
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          const Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(
                                    x["original_title"],
                                    style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                                  ),
                                )))
                            .toList(),
                      ),
                    ))
                .toList()),
      );
    }));
  }
}
