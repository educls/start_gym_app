import 'package:flutter/material.dart';
import 'package:start_gym_app/views/home/aluno/dashboard_aluno_page.dart';
import 'package:start_gym_app/views/home/professor/dashboard_professor_page.dart';

import '../../views/home/admin/agenda_treinos_admin_page.dart';
import '../../views/home/admin/alunos_admin_page.dart';
import '../../views/home/admin/professores_admin_page.dart';
import '../../views/home/admin/treinos_admin_page.dart';
import '../../views/home/aluno/edit_perfil_aluno_page.dart';
import '../../views/home/aluno/treinos_aluno.dart';
import '../../views/home/professor/agenda_treinos_page.dart';
import '../../views/home/professor/treinos_professor_page.dart';

class BarPagesConst {
  static List<Widget> getBottomBarPagesProfessor() {
    return [
      const DashboardProfessorPage(),
      const TreinosProfessorPage(),
      const AgendaTreinosProfessorPage(),
      const AlunosAdminPage(),
    ];
  }

  static List<Widget> getBottomBarPagesAluno() {
    return [
      const DashboardAlunoPage(),
      const TreinosAlunoPage(),
      const PerfilAlunoPage(),
    ];
  }

  static List<Widget> getBottomBarPagesAdmin() {
    return [
      const TreinosAdminPage(),
      const AlunosAdminPage(),
      const AgendaTreinosAdminPage(),
      const ProfessoresAdminPage(),
    ];
  }
}
