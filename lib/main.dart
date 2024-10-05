import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_gym_app/views/home/admin/edit_admin_infos_page.dart';
import 'package:start_gym_app/views/home/admin/home_page_admin.dart';
import 'package:start_gym_app/views/home/admin/sign_up_new_aluno_page.dart';
import 'package:start_gym_app/views/home/aluno/edit_aluno_infos_page.dart';
import 'package:start_gym_app/views/home/aluno/home_page_aluno.dart';
import 'package:start_gym_app/views/home/professor/edit_professor_infos_page.dart';
import 'package:start_gym_app/views/home/professor/home_page_professor.dart';
import 'package:start_gym_app/views/home/professor/treino/adicionar_treino_page.dart';

import 'Views/home/professor/exercicios/abdomen_page.dart';
import 'Views/home/professor/exercicios/aerobico_page.dart';
import 'Views/home/professor/exercicios/alongamento_page.dart';
import 'Views/home/professor/exercicios/antebracos_page.dart';
import 'Views/home/professor/exercicios/biceps_page.dart';
import 'Views/home/professor/exercicios/dorsal_page.dart';
import 'Views/home/professor/exercicios/inferiores_page.dart';
import 'Views/home/professor/exercicios/ombros_page.dart';
import 'Views/home/professor/exercicios/peitoral_page.dart';
import 'Views/home/professor/exercicios/triceps_page.dart';
import 'views/login/login_page.dart';
import 'views/home/admin/sign_up_new_teacher_page.dart';
import 'views/home/home_page.dart';
import 'views/signUp/sign_up_page.dart';

import './utils/provider/data_provider.dart';

import 'common/color_extension.dart';

void main() {
  runApp(
    const MyApp()
    // MultiProvider(
    //   providers: [ChangeNotifierProvider(create: (_) => DataAppProvider())],
    //   child: const MyApp(),
    // ),
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
        '/adicionar-treino': (context) => const CategoriaMuscScreen(),
        '/ombros': (context) => const OmbrosPage(),
        '/peitoral': (context) => const PeitoralPage(),
        '/biceps': (context) => const BicepsPage(),
        '/triceps': (context) => const TricepsPage(),
        '/antebracos': (context) => const AntebracosPage(),
        '/dorsal': (context) => const DorsalPage(),
        '/abdomen': (context) => const AbdomenPage(),
        '/inferiores': (context) => const InferioresPage(),
        '/aerobico': (context) => const AerobicoPage(),
        '/alongamento': (context) => const AlongamentoPage(),
      },
    );
  }
}
