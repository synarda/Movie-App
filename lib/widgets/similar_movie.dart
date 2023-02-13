// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/detail_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/detail_page.dart';
import 'package:provider_api/utils/const.dart';

class SimilarMovieWidget extends StatelessWidget {
  const SimilarMovieWidget({
    Key? key,
    required this.data,
    this.isGame = false,
  }) : super(key: key);
  final String data;
  final bool isGame;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      width: double.infinity,
      child: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (context) => ChangeNotifierProvider(
                                create: (ctx) => DetailProvider(e.id, context.read<GlobalProvider>()),
                                child: DetailPage(
                                    isGame: isGame == true ? false : true,
                                    adult: e.adult,
                                    data: data,
                                    id: e.id,
                                    imgUrl: e.imgUrl,
                                    accountId: Provider.of<LoginProvider>(context).account.id),
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                                  child: SizedBox(height: 30, width: 30, child: Image.asset("assets/noimage.png")),
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "https://image.tmdb.org/t/p/original/${e.imgUrl}",
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                            style: const TextStyle(color: Colorss.textColor, fontSize: 8),
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
    );
  }
}
