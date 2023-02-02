import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/screen/login_page.dart';
import 'package:provider_api/screen/route_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("sessionBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final loginProvider = LoginProvider();
  final routeProvider = RoutePageProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(create: (ctx) => loginProvider),
          ChangeNotifierProvider<RoutePageProvider>(create: (ctx) => routeProvider)
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Hive.box("sessionBox").isEmpty ? const LoginPage() : const RoutePage()));
  }
}
