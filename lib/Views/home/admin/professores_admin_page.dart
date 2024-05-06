import 'package:flutter/material.dart';

class ProfessoresAdminPage extends StatefulWidget {
  const ProfessoresAdminPage({super.key});

  @override
  State<ProfessoresAdminPage> createState() => _ProfessoresAdminPageState();
}

class _ProfessoresAdminPageState extends State<ProfessoresAdminPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lista de Professores'),
    );
  }
}
