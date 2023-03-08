import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/model/NewsArticaleModel.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/services/NewsProvider.dart';
import 'package:news_app/services/ThemeProvider.dart';
import 'package:news_app/util/loding.dart';
import 'package:news_app/util/theem/colours.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: Builder(
        builder: (BuildContext context) {
          final theme = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: theme.themeMode,
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.orange,
                textTheme: const TextTheme(
                    displayLarge: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    displayMedium: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                appBarTheme: AppBarTheme(
                    backgroundColor: LightBackground,
                    titleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: LightheadingColour)),
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                    .copyWith(
                    background: LightBackground,
                    secondary: LightScondery,
                    brightness: Brightness.light)
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: Colors.orange,
                textTheme: const TextTheme(
                    displayLarge: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    displayMedium: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                appBarTheme: AppBarTheme(
                    backgroundColor: DarkBackground,
                    titleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: DarkheadingColour)),
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                    .copyWith(
                        background: DarkBackground,
                        secondary: DarkScondery,
                        brightness: Brightness.dark)),
            home: const Home(),
            // home: ImplicitAnimationsExample(),
          );
        },
      ),
    );
  }
}
