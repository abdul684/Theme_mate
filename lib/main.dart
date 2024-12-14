import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/main_screen.dart';
import 'Screen/theme_notifier.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Theme App',
      theme: themeNotifier.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home:  MainScreen(),
    );
  }
}
