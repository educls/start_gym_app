import 'package:flutter/material.dart';

import '../Views/home/home_page.dart';

class NavBarItemsCustom {
  final NavBarType type;

  NavBarItemsCustom(this.type);

  List<BottomNavigationBarItem> getItems() {
    switch (type) {
      case NavBarType.admin:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Professores',
          ),
        ];
      case NavBarType.professor:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agenda',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Perfil',
          // ),
        ];
      case NavBarType.aluno:
        return const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ];
    }
  }
}
