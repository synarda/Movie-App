// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_movie_provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/animated_listview.dart';

class AddMovieAlertPage extends StatefulWidget {
  const AddMovieAlertPage({
    Key? key,
    required this.accounId,
    required this.movieId,
  }) : super(key: key);
  final String accounId;
  final int movieId;
  @override
  State<AddMovieAlertPage> createState() => _AddMovieAlertPageState();
}

class _AddMovieAlertPageState extends State<AddMovieAlertPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          textAlign: TextAlign.center,
          "Add Movie",
          style: TextStyle(color: Colorss.textColor),
        ),
        backgroundColor: Colorss.background,
        content: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Consumer<ListsProvider>(builder: (context, provider, child) {
                  return AnimatedListView(
                    key: ValueKey(context.read<RoutePageProvider>().pageIdx),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    children: provider.lists
                        .map((listItem) => Container(
                              key: ValueKey(listItem.id),
                              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colorss.themeFirst.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colorss.background),
                              child: ListTile(
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colorss.forebackground),
                                    child: Center(
                                      child: Text(
                                        listItem.name
                                            .toString()
                                            .trim()
                                            .toUpperCase()
                                            .substring(0, 1),
                                        style: const TextStyle(
                                            color: Colorss.textColor, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                title: Text(listItem.name,
                                    style: TextStyle(
                                        color: Colorss.textColor.withOpacity(0.8),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                trailing: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colorss.themeFirst,
                                    ),
                                    onPressed: () {
                                      final sessionBox = Hive.box("sessionBox");
                                      final sessionId = sessionBox.get("sessionId");

                                      context
                                          .read<AddMovieProvider>()
                                          .addMovie(listItem.id.toString(), sessionId,
                                              widget.movieId.toString())
                                          .then((value) => Navigator.pop(context));
                                    }),
                                subtitle: Text(
                                  listItem.description,
                                  style: TextStyle(
                                      color: Colorss.textColor.withOpacity(0.5), fontSize: 10),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }))));
  }
}
