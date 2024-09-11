import 'package:flutter/material.dart';

class CategoriaMuscScreen extends StatefulWidget {
  const CategoriaMuscScreen({super.key});

  @override
  State<CategoriaMuscScreen> createState() => _CategoriaMuscScreenState();
}

class _CategoriaMuscScreenState extends State<CategoriaMuscScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44), // Fundo azul escuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1F44), // Azul escuro
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Ação para voltar
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Coloque sua imagem do logotipo aqui
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text('Start Gym'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  _buildGridItem('Ombros', 'assets/ombros.png'),
                  _buildGridItem('Peitoral', 'assets/peitoral.png'),
                  _buildGridItem('Bíceps', 'assets/biceps.png'),
                  _buildGridItem('Tríceps', 'assets/triceps.png'),
                  _buildGridItem('Antebraços', 'assets/antebracos.png'),
                  _buildGridItem('Dorsal', 'assets/dorsal.png'),
                  _buildGridItem('Abdômen', 'assets/abdomen.png'),
                  _buildGridItem('Inferiores', 'assets/inferiores.png'),
                  _buildGridItem('Aeróbicos', 'assets/aerobicos.png'),
                  _buildGridItem('Alongamentos', 'assets/alongamentos.png'),
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
              child: Image.asset(imagePath),
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