import 'package:flutter/material.dart';

class HomePageProfessor extends StatefulWidget {
  const HomePageProfessor({super.key});

  @override
  State<HomePageProfessor> createState() => _HomePageProfessorState();
}

class _HomePageProfessorState extends State<HomePageProfessor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Professor"),
      ),
    );
  }
}
