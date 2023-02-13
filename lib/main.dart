import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/game_alert_provider.dart';
import 'package:provider_api/providers/globalProvider.dart';
import 'package:provider_api/providers/home_provider.dart';
import 'package:provider_api/providers/login_provider.dart';
import 'package:provider_api/providers/route_provider.dart';
import 'package:provider_api/screen/login_page.dart';
import 'package:provider_api/screen/route_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("sessionBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routeProvider = RoutePageProvider();
    final globalProvider = GlobalProvider();
    final homeProvider = HomeProvider();
    final gameAlertProvider = GameAlertProvider(context);

    final loginProvider = LoginProvider(globalProvider);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (ctx) => loginProvider),
        ChangeNotifierProvider<HomeProvider>(create: (ctx) => homeProvider),
        ChangeNotifierProvider<RoutePageProvider>(create: (ctx) => routeProvider),
        ChangeNotifierProvider<GlobalProvider>(create: (ctx) => globalProvider),
        ChangeNotifierProvider<GameAlertProvider>(create: (ctx) => gameAlertProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Hive.box("sessionBox").isEmpty ? const LoginPage() : const RoutePage(),
      ),
    );
  }
}
