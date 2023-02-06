// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/account_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/screen/favorite_page.dart';
import 'package:provider_api/screen/login_page.dart';
import 'package:provider_api/utils/const.dart';
import 'package:provider_api/widgets/custom_account_listtile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);
  final String accountId;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 16, left: 16),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colorss.background.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://www.gravatar.com/avatar/${Provider.of<LoginProvider>(context).account.avatarHash}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(top: 16, right: 16, left: 5),
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colorss.background,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                  child: ListTile(
                    title: Text(
                      "welcome  ${provider.account.userName}",
                      style: const TextStyle(color: Colorss.textColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritePage(),
                      ));
                },
                child: CustomAccountListtile(
                    textColor: Colorss.textColor,
                    icon: Icon(
                      Icons.favorite,
                      color: Colorss.textColor.withOpacity(0.7),
                    ),
                    text: "Favorite"),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<AccountProvider>(context, listen: false)
                      .deleteSession()
                      .then((value) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    context.read<LoginProvider>().isLoading = true;
                  });
                },
                child: CustomAccountListtile(
                    textColor: Colorss.themeFirst,
                    icon: Icon(
                      Icons.logout,
                      color: Colorss.themeFirst.withOpacity(0.7),
                    ),
                    text: "Log out"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
