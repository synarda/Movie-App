import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_provider.dart';
import 'package:provider_api/providers/navigate_provider.dart';
import 'package:provider_api/screen/add_alert_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/animated_listview.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

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
                      value: context.read<AddProvider>(), child: const AddAlertPage()));
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
                children: const [
                  Text(
                    "add",
                    style: TextStyle(color: Colorss.themeFirst),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.add,
                    color: Colorss.themeFirst,
                  ),
                ],
              ),
            ),
          ),
          Consumer<AddProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: AnimatedListView(
                  key: ValueKey(context.read<NavigateProvider>().pageIdx),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  children: provider.lists
                      .map((listItem) => Container(
                            key: ValueKey(listItem.id),
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colorss.themeFirst.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ], borderRadius: BorderRadius.circular(20), color: Colorss.background),
                            child: ListTile(
                              title: Text(listItem.name,
                                  style: TextStyle(
                                      color: Colorss.textColor.withOpacity(0.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colorss.themeFirst,
                                  ),
                                  onPressed: () => provider.deleteList(listItem.id)),
                              subtitle: Text(
                                listItem.description,
                                style: TextStyle(
                                    color: Colorss.textColor.withOpacity(0.5), fontSize: 10),
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
