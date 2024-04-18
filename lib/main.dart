import 'package:flutter/material.dart';

import 'Views/Login/login_page.dart';
import 'Views/home/home_page.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { setToken }

String token(String state, dynamic action) {
  if (action == Actions.setToken) {
    return state = 'chego';
  }
  return '';
}

void main() {
  final store = Store<String>(token, initialState: "vazio");
  runApp(MyApp(
    title: 'Start Gym',
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<String> store;
  final String title;
  MyApp({super.key, required this.store, required this.title});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<String>(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/login',
          routes: {
            '/home': (context) => HomePage(),
            '/login': (context) => const LoginPage()
          },
        ));
  }
}
