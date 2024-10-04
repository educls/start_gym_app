import 'package:flutter/material.dart';

class TreinoPorCategoriaScreen extends StatefulWidget {
  const TreinoPorCategoriaScreen({super.key});

  @override
  State<TreinoPorCategoriaScreen> createState() =>
      _TreinoPorCategoriaScreenState();
}

class _TreinoPorCategoriaScreenState extends State<TreinoPorCategoriaScreen> {
  final List<bool> _selectedExercises = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Gym", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0A1E5C), // Azul escuro
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Ação para o botão voltar
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de busca
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            // Título da seção
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A1E5C),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text(
                'Ombros',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 16.0),
            // Lista de exercícios
            Expanded(
              child: ListView(
                children: [
                  _buildExerciseTile("Desenvolvimento com halteres", 0),
                  _buildExerciseTile("Desenvolvimento com Barra fixa", 1),
                  _buildExerciseTile("Desenvolvimento com halteres", 2),
                  _buildExerciseTile("Desenvolvimento com halteres", 3),
                  _buildExerciseTile("Desenvolvimento com halteres", 4),
                ],
              ),
            ),
            // Botão Finalizar Treino
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação ao finalizar o treino
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  // primary: Colors.orange,
                ),
                child: const Text(
                  "FINALIZAR TREINO",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os itens da lista de exercícios
  Widget _buildExerciseTile(String title, int index) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(title),
          value: _selectedExercises[index],
          onChanged: (bool? value) {
            setState(() {
              _selectedExercises[index] = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const Divider(
          thickness: 1.0,
          color: Colors.orange,
        ),
      ],
    );
  }
}
