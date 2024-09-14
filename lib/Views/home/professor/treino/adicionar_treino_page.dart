import 'package:flutter/material.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';
import 'package:start_gym_app/widgets/custom_back_button.dart';

import '../../../../widgets/appbar/custom_appbar_edit_user.dart';

class CategoriaMuscScreen extends StatefulWidget {
  const CategoriaMuscScreen({super.key});

  @override
  State<CategoriaMuscScreen> createState() => _CategoriaMuscScreenState();
}

class _CategoriaMuscScreenState extends State<CategoriaMuscScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44), // Fundo azul escuro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomAppBarEditUser(
              title: "Start Gym",
              pathLogo: PathConstants.logoStartGym,
            ),
            const CustomBackButton(),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Buscar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildGridItem('Ombros', 'assets/images/adicionar_treino/ombro.png'),
                  _buildGridItem('Peitoral', 'assets/images/adicionar_treino/peitoral.png'),
                  _buildGridItem('Bíceps', 'assets/images/adicionar_treino/biceps.png'),
                  _buildGridItem('Tríceps', 'assets/images/adicionar_treino/triceps.png'),
                  _buildGridItem('Antebraços', 'assets/images/adicionar_treino/antebraco.png'),
                  _buildGridItem('Dorsal', 'assets/images/adicionar_treino/dorsal.png'),
                  _buildGridItem('Abdômen', 'assets/images/adicionar_treino/abdominal.png'),
                  _buildGridItem('Inferiores', 'assets/images/adicionar_treino/inferiores.png'),
                  _buildGridItem('Aeróbicos', 'assets/images/adicionar_treino/aerobico.png'),
                  _buildGridItem('Alongamentos', 'assets/images/adicionar_treino/alongamento.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String imagePath) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueAccent, // Para destacar o item selecionado
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imagePath, ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}