import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/list_detail_provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/screen/alerts/addList_alert_page.dart';
import 'package:provider_api/screen/alerts/delete_alert_page.dart';
import 'package:provider_api/screen/list_detail_page.dart';
import 'package:provider_api/utils/const.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (x) => ChangeNotifierProvider.value(
                      value: context.read<ListsProvider>(), child: const AddAlertPage()));
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colorss.background.withOpacity(0.8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "add",
                    style: TextStyle(color: Colorss.themeFirst),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.add,
                    color: Colorss.themeFirst,
                  ),
                ],
              ),
            ),
          ),
          Consumer<ListsProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: provider.lists
                      .map((listItem) => GestureDetector(
                            onTap: () {
                              final sessionBox = Hive.box("sessionBox");
                              final sessionId = sessionBox.get("sessionId");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider<ListDetailProvider>(
                                            create: (ctx) => ListDetailProvider(
                                                listItem.id.toString(), sessionId),
                                            child: ListDetailPage(
                                              name: listItem.name,
                                              description: listItem.description,
                                              itemCount: listItem.itemCount,
                                            ),
                                          )));
                            },
                            child: Container(
                              key: ValueKey(listItem.id),
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(10),
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
                                    height: 60,
                                    width: 60,
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
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colorss.themeFirst,
                                    ),
                                    onPressed: () async {
                                      final result = await showDialog(
                                          context: context,
                                          builder: (x) => const DeleteAlertPage());
                                      if (result == true) {
                                        provider.deleteList(listItem.id);
                                      }
                                    }),
                                subtitle: Text(
                                  listItem.description,
                                  style: TextStyle(
                                      color: Colorss.textColor.withOpacity(0.5), fontSize: 10),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
