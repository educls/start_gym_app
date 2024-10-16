import 'package:flutter/material.dart';
import 'package:start_gym_app/Views/home/professor/exercicios/criar_treino_por_categoria_screen.dart';
import 'package:start_gym_app/Views/home/professor/exercicios/definicoes_exercicio_page.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';
import 'package:start_gym_app/widgets/custom_back_button.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';

import '../../../../widgets/appbar/custom_appbar_edit_user.dart';

class CategoriaMuscScreen extends StatefulWidget {
  const CategoriaMuscScreen({super.key});

  @override
  State<CategoriaMuscScreen> createState() => _CategoriaMuscScreenState();
}

class _CategoriaMuscScreenState extends State<CategoriaMuscScreen> {
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            children: [
              Row(
                children: [
                  const CustomBackButton(), // Alinhado à esquerda
                  const SizedBox(width: 30), // Espaço entre o botão e a imagem
                  Image.asset(
                    'assets/images/logoStartGymAmarelo.png',
                    height: screenHeight * 0.09, // Altura da imagem
                  ),
                  const SizedBox(width: 10), // Espaço entre a imagem e o texto
                  Container(
                    height: screenHeight *
                        0.09, // Ajuste a altura conforme necessário
                    alignment: Alignment
                        .bottomLeft, // Alinhando o texto à parte inferior
                    child: Text(
                      "Start Gym",
                      style: TextStyle(
                        color: Colors.white, // Cor do texto
                        fontSize: screenHeight * 0.03, //  altura da tela
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: screenHeight * 0.07,
                child: TextField(
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
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20,
                  children: [
                    _buildGridItem('Ombros', PathConstants.ombro, '/ombros'),
                    _buildGridItem(
                        'Peitoral', PathConstants.peitoral, '/peitoral'),
                    _buildGridItem('Bíceps', PathConstants.biceps, '/biceps'),
                    _buildGridItem(
                        'Tríceps', PathConstants.triceps, '/triceps'),
                    _buildGridItem(
                        'Antebraços', PathConstants.antebraco, '/antebracos'),
                    _buildGridItem('Dorsal', PathConstants.dorsal, '/dorsal'),
                    _buildGridItem(
                        'Abdômen', PathConstants.abdominal, '/abdomen'),
                    _buildGridItem(
                        'Inferiores', PathConstants.inferiores, '/inferiores'),
                    _buildGridItem(
                        'Aeróbico', PathConstants.aerobico, '/aerobico'),
                    _buildGridItem('Alongamento', PathConstants.alongamento,
                        '/alongamento'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String imagePath, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DefinicoesExercicioPage(title: title)));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 200, // Largura fixa
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
