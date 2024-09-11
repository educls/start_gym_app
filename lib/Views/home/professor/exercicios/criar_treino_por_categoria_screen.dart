import 'package:flutter/material.dart';

class CriarTreinoPorCategoriaScreen extends StatefulWidget {
  const CriarTreinoPorCategoriaScreen({super.key});

  @override
  State<CriarTreinoPorCategoriaScreen> createState() => _CriarTreinoPorCategoriaScreenState();
}

class _CriarTreinoPorCategoriaScreenState extends State<CriarTreinoPorCategoriaScreen> {
  // Valores pré-definidos
  final int _series = 3;
  final int _reps = 15;
  final int _rest = 40;

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
            // Título do exercício
            const Center(
              child: Text(
                "Desenvolvimento com halteres",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1E5C),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Imagem do exercício
            Center(
              child: Image.asset(
                'assets/dumbbell_press.png', // Substituir pelo caminho da imagem correta
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            // Campo de alteração de vídeo
            TextField(
              enabled: false, // Campo não editável
              decoration: InputDecoration(
                labelText: "Alterar vídeo",
                hintText: "Link vídeo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            // Séries, repetições e descanso
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Séries
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Séries:"),
                    const SizedBox(height: 10),
                    _buildInfoBox(_series.toString()),
                  ],
                ),
                // Repetições
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Repetições:"),
                    const SizedBox(height: 10),
                    _buildInfoBox(_reps.toString()),
                  ],
                ),
                // Descanso
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Descanso:"),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildInfoBox(_rest.toString()),
                        const SizedBox(width: 5),
                        const Text("seg"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Botão adicionar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ação ao adicionar exercício
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  // primary: Colors.orange,
                ),
                child: const Text(
                  "ADICIONAR",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os valores das caixas de séries, repetições e descanso
  Widget _buildInfoBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
