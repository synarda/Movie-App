// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    Key? key,
    required this.accountId,
  }) : super(key: key);
  final String accountId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.forebackground,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  accountId.toString(),
                  style: const TextStyle(color: Colorss.textColor),
                ),
              ),
              Container(),
            ],
          )
        ],
      ),
    );
  }
}
