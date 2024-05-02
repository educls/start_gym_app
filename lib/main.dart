import 'package:flutter/material.dart';
import 'package:start_gym_app/Views/home/admin/home_admin_page.dart';
import 'package:start_gym_app/Views/home/aluno/home_aluno_page.dart';
import 'package:start_gym_app/Views/home/professor/home_professor_page.dart';

import 'Views/Login/login_page.dart';
import 'Views/home/home_page.dart';
import 'Views/signUp/sign_up_page.dart';

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
        '/cadastro': (context) => const SignUpPage(),
        '/home': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
