import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/lists_provider.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/textfield.dart';

class AddAlertPage extends StatefulWidget {
  const AddAlertPage({super.key});

  @override
  State<AddAlertPage> createState() => _AddAlertPageState();
}

class _AddAlertPageState extends State<AddAlertPage> {
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorss.background.withOpacity(0.5),
              ),
            ),
          ),
        ),
        AlertDialog(
          backgroundColor: Colorss.background.withOpacity(0.7),
          content: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colorss.themeFirst)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  "Add List",
                  style: TextStyle(color: Colorss.textColor),
                ),
                GestureDetector(
                  onTap: FocusScope.of(context).unfocus,
                  child: SizedBox(
                    child: Column(children: [
                      TextfieldWidget(
                        label: "Name",
                        limit: 50,
                        obscure: false,
                        controller: nameController,
                      ),
                      TextfieldWidget(
                        label: "Description",
                        limit: 50,
                        obscure: false,
                        controller: descController,
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        final provider = context.read<ListsProvider>();
                        provider
                            .createList(nameController.text, descController.text)
                            .then((value) => Navigator.pop(context));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colorss.themeFirst,
                          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      child: const Text(
                        "Save List",
                        style: TextStyle(color: Colorss.forebackground, fontSize: 12),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
