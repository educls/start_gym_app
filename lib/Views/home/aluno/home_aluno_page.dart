import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start_gym_app/Views/home/aluno/perfil_aluno.dart';
import 'package:start_gym_app/Views/home/aluno/treinos_aluno.dart';

class HomePageAluno extends StatefulWidget {
  const HomePageAluno({super.key});

  @override
  State<HomePageAluno> createState() => _HomePageAlunoState();
}

class _HomePageAlunoState extends State<HomePageAluno> {
  int _currentIndex = 0;
  List<Widget> bottomBarPages = const [
    TreinosAlunoPage(),
    PerfilAlunoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Aluno"),
      ),
      body: Center(
        child: bottomBarPages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(204, 236, 236, 236),
        selectedFontSize: 20,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
