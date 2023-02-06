import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/favorite_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/animated_listview.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      appBar: AppBar(
        backgroundColor: Colorss.background,
        title: const Text("Movie's Favorite"),
        centerTitle: true,
      ),
      body: Consumer<FavoriteProvider>(builder: (context, provider, child) {
        return provider.favoriteList.isEmpty
            ? Center(
                child: SizedBox(height: 250, width: 500, child: Lottie.asset("assets/ghostt.json")))
            : AnimatedListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: provider.favoriteList
                    .map((x) => GestureDetector(
                          key: ValueKey(x.backdropPath),
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
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colorss.themeFirst,
                                  ),
                                  onPressed: () {
                                    context.read<FavoriteProvider>().postMarkFavorite(
                                        x, context.read<LoginProvider>().account.id);
                                  },
                                ),
                                title: Text(
                                  x.title,
                                  style: const TextStyle(color: Colorss.textColor, fontSize: 12),
                                ),
                              )),
                        ))
                    .toList());
      }),
    );
  }
}
