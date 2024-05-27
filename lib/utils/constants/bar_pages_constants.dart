import 'package:flutter/material.dart';

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
    const TreinosProfessorPage(),
    const AgendaTreinosProfessorPage(),
    const AlunosAdminPage(),
  ];
  }

  static List<Widget> getBottomBarPagesAluno() {
    return [
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