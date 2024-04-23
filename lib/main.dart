import 'package:flutter/material.dart';

import 'Views/Login/login_page.dart';
import 'Views/home/home_page.dart';
import './utils/provider/data_provider.dart';

import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [Provider(create: (_) => DataAppProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Start Gym',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}
