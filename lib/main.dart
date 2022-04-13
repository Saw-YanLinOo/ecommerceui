import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerceui/provider/theme_provider.dart';
import 'package:ecommerceui/screen/drawer/setting.dart';
import 'package:ecommerceui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..getTheme(),),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('my', 'MM')],
         path: 'assets/translations',
         fallbackLocale: const Locale('en', 'US'),
         child: const MyApp(),
         ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeProvider.themeMode,
        initialRoute: Home.route,
        routes: {
          Home.route:(context)=> const Home(),
          Setting.route: (context) => Setting(),
        },
      );
  }
}