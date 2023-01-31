import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/add_provider.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_textfield.dart';

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
    return AlertDialog(
      title: const Text(
        textAlign: TextAlign.center,
        "Add List",
        style: TextStyle(color: Colorss.textColor),
      ),
      backgroundColor: Colorss.background.withOpacity(0.7),
      content: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(children: [
            CustomTextField(
              label: "Name",
              limit: 50,
              obscure: false,
              controller: nameController,
            ),
            CustomTextField(
              label: "Description",
              limit: 50,
              obscure: false,
              controller: descController,
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    final provider = context.read<AddProvider>();
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
          ]),
        ),
      ),
    );
  }
}
