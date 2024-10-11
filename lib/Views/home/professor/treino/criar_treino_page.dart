import 'package:flutter/material.dart';

class CriarTreinoScreen extends StatefulWidget {
  const CriarTreinoScreen({super.key});

  @override
  State<CriarTreinoScreen> createState() => _CriarTreinoScreenState();
}

class _CriarTreinoScreenState extends State<CriarTreinoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: const Color(0xFF0A1E5C),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoStartGymAmarelo.png', // Substitua pelo caminho da sua imagem
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text('Start Gym', style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de nome do treino
            TextField(
              decoration: InputDecoration(
                hintText: 'Nome do treino',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de exercícios
            Expanded(
              child: ListView(
                children: [
                  buildExercicioItem(
                    'Alongamento posterior',
                    'Alongamento',
                    series: '3',
                    repeticoes: '3',
                    descanso: '40 segundos',
                  ),
                  buildExercicioItem(
                    'Agachamento livre',
                    'Inferiores',
                  ),
                  buildExercicioItem(
                    'Desenvolvimento com halteres',
                    'Ombro',
                  ),
                  buildExercicioItem(
                    'Corrida na esteira',
                    'Aeróbico',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Campo de observações
            const Text('Observações'),
            const SizedBox(height: 8),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Botões na parte inferior
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação para finalizar treino
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'FINALIZAR TREINO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação para adicionar exercício
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'ADICIONAR EXERCICIO',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para criar itens da lista de exercícios
  Widget buildExercicioItem(String titulo, String subtitulo, {String series = '-', String repeticoes = '-', String descanso = '-'}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: false, // Apenas visual, lógica não implementada
                onChanged: (bool? value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitulo,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Séries: $series'),
                Text('Repetições: $repeticoes'),
                Text('Descanso: $descanso'),
              ],
            ),
          ),
          const Divider(
            color: Colors.orange,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
