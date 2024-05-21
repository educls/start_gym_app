import 'package:flutter/material.dart';
import 'package:start_gym_app/Views/home/admin/sign_up_new_aluno_page.dart';
import 'package:start_gym_app/Views/home/edit_info_user_page.dart';

import 'Views/Login/login_page.dart';
import 'Views/home/admin/sign_up_new_teacher_page.dart';
import 'Views/home/home_page.dart';
import 'Views/questions/questions_page.dart';
import 'Views/signUp/sign_up_page.dart';

import './utils/provider/data_provider.dart';

import 'package:provider/provider.dart';

import 'common/color_extension.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.darkBlue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/cadastro': (context) => const SignUpPage(),
        '/home': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/edit-user-perfil': (context) => const EditInfoUserPage(),
        '/sign-up-new-teacher': (context) => const SignUpNewTeacher(),
        '/sign-up-new-Aluno': (context) => const SignUpNewAluno(),
      },
    );
  }
}
