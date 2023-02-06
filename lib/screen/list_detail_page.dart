// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/favorite_provider.dart';
import 'package:provider_api/providers/list_detail_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/alerts/delete_alert_page.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/animated_listview.dart';

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({
    Key? key,
    required this.name,
    required this.itemCount,
    required this.description,
  }) : super(key: key);
  final String name;
  final int itemCount;
  final String description;
  @override
  Widget build(BuildContext context) {
    // Provider.of<ListDetailProvider>()
    final provider = context.watch<ListDetailProvider>();

    //Provider.of<ListDetailProvider>(listen: false) = context.read<ListDetailProvider>()
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      appBar: AppBar(backgroundColor: Colorss.background, centerTitle: true, title: Text(name)),
      body: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(24),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colorss.background),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("created by: ", style: TextStyle(color: Colorss.themeFirst)),
                      Text(provider.listDetail?.createdBy ?? "Loading...",
                          style: const TextStyle(color: Colorss.textColor)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("description: ", style: TextStyle(color: Colorss.themeFirst)),
                      Text(description, style: const TextStyle(color: Colorss.textColor)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("item Count: ", style: TextStyle(color: Colorss.themeFirst)),
                      Text(itemCount.toString(), style: const TextStyle(color: Colorss.textColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          (provider.listDetail?.items ?? []).isEmpty
              ? Center(
                  child:
                      SizedBox(height: 250, width: 500, child: Lottie.asset("assets/ghostt.json")))
              : Expanded(
                  child: AnimatedListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      children: (provider.listDetail?.items ?? [])
                          .map((x) => GestureDetector(
                                key: ValueKey(x.id),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ChangeNotifierProvider(
                                        create: (ctx) =>
                                            DetailProvider(x.id, context.read<FavoriteProvider>()),
                                        child: DetailPage(
                                          imgUrl: x.backdropPath,
                                          id: x.id,
                                          data: "",
                                          adult: false,
                                          accountId: Provider.of<LoginProvider>(context).account.id,
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: Container(
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
                                              "https://image.tmdb.org/t/p/original/${x.backdropPath}",
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) => const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      title: Text(
                                        x.title,
                                        style:
                                            const TextStyle(color: Colorss.textColor, fontSize: 12),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colorss.themeFirst,
                                        ),
                                        onPressed: () async {
                                          final result = await showDialog(
                                              context: context,
                                              builder: (a) => const DeleteAlertPage());
                                          if (result == true) {
                                            final sessionBox = Hive.box("sessionBox");
                                            final sessionId = sessionBox.get("sessionId");
                                            provider.deleteListInMovie(
                                                provider.listDetail!.id, sessionId, x.id);
                                          }
                                        },
                                      ),
                                    )),
                              ))
                          .toList()),
                ),
        ],
      ),
    );
  }
}
