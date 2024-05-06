import 'package:flutter/material.dart';

class AgendaTreinosProfessorPage extends StatefulWidget {
  const AgendaTreinosProfessorPage({super.key});

  @override
  State<AgendaTreinosProfessorPage> createState() =>
      _AgendaTreinosProfessorPageState();
}

class _AgendaTreinosProfessorPageState
    extends State<AgendaTreinosProfessorPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Agenda de treinos do dia/semana/mes'),
    );
  }
}
