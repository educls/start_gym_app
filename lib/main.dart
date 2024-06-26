import 'package:flutter/material.dart';
import 'package:start_gym_app/views/home/admin/edit_admin_infos_page.dart';
import 'package:start_gym_app/views/home/admin/home_page_admin.dart';
import 'package:start_gym_app/views/home/admin/sign_up_new_aluno_page.dart';
import 'package:start_gym_app/views/home/aluno/edit_aluno_infos_page.dart';
import 'package:start_gym_app/views/home/aluno/home_page_aluno.dart';
import 'package:start_gym_app/views/home/professor/edit_professor_infos_page.dart';
import 'package:start_gym_app/views/home/professor/home_page_professor.dart';

import 'views/login/login_page.dart';
import 'views/home/admin/sign_up_new_teacher_page.dart';
import 'views/home/home_page.dart';
import 'views/signUp/sign_up_page.dart';

import './utils/provider/data_provider.dart';

import 'package:provider/provider.dart';

import 'common/color_extension.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataAppProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/home_admin': (context) => const HomePageAdmin(),
        '/home_professor': (context) => const HomePageProfessor(),
        '/home_aluno': (context) => const HomePageAluno(),
        '/home': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/sign-up-new-teacher': (context) => const SignUpNewTeacher(),
        '/sign-up-new-aluno': (context) => const SignUpNewAluno(),
        '/edit-aluno-perfil': (context) => const EditAlunoInfosPage(),
        '/edit-admin-perfil': (context) => const EditAdminInfosPage(),
        '/edit-professor-perfil': (context) => const EditProfessorInfosPage(),
      },
    );
  }
}
