import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendguardian/theme_notifier.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'reports_page.dart';
import 'transaction_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeNotifier>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: LoginPage(), // Set the initial page to LoginPage
      routes: {
        '/home': (context) => HomePage(),
        '/transactions': (context) => TransactionsPage(),
        '/reports': (context) => ReportsPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
