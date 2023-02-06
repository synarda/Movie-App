import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_api/providers/favorite_provider.dart';
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
    final favoriteProvider = FavoriteProvider();
    final loginProvider = LoginProvider(favoriteProvider);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (ctx) => loginProvider),
        ChangeNotifierProvider<RoutePageProvider>(create: (ctx) => routeProvider),
        ChangeNotifierProvider<FavoriteProvider>(create: (ctx) => favoriteProvider)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Hive.box("sessionBox").isEmpty ? const LoginPage() : const RoutePage(),
      ),
    );
  }
}
