import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/screen/route_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colorss.background,
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150,
              child: Lottie.asset("assets/movieLottie.json"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                label: "Username",
                limit: 50,
                obscure: false,
                controller: provider.userNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                  label: "Password",
                  limit: 50,
                  obscure: false,
                  controller: provider.passwordController),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    provider
                        .postAuth(
                            provider.userNameController.text, provider.passwordController.text)
                        .then((success) {
                      if (success) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                      create: (ctx) => RoutePageProvider(),
                                      child: const RoutePage(),
                                    )));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colorss.themeFirst,
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colorss.forebackground, fontSize: 12),
                  )),
            ),
          ])),
        ),
      ),
    );
  }
}
