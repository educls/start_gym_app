import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:start_gym_app/Views/home/professor/treino/criar_treino_page.dart';
import 'package:start_gym_app/widgets/custom_back_button.dart';

import '../../../../common/color_extension.dart';

class DefinicoesExercicioPage extends StatefulWidget {
  final String title;
  const DefinicoesExercicioPage({super.key, required this.title});

  @override
  State<DefinicoesExercicioPage> createState() => _DefinicoesExercicioPageState();
}

class _DefinicoesExercicioPageState extends State<DefinicoesExercicioPage> {
  // Valores pré-definidos
  final int _series = 0;
  final int _reps = 0;
  final int _rest = 00;

  TextEditingController controller = TextEditingController(text: 'Nome Exercício');
  TextEditingController controllerSeries = TextEditingController(text: '0');
  TextEditingController controllerReps = TextEditingController(text: '0');
  TextEditingController controllerRest = TextEditingController(text: '00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A1E5C),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              // Título do exercício
              Center(
                child: TextField(
                  style: TextStyle(
                    color: TColor.lighBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                  ),
                ),
              ),
              Divider(
                color: TColor.primaryColor1,
              ),
              const SizedBox(height: 10),
              // Imagem do exercício
              Center(
                child: Image.asset(
                  'assets/img/detail_top.png', // Substituir pelo caminho da imagem correta
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              // Campo de alteração de vídeo
              TextField(
                enabled: true, // Campo não editável
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Séries
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Séries:"),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: _buildInfoBox(_series.toString(), controllerSeries),
                        ),
                      ],
                    ),
                  ),
                  // Repetições
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Repetições:"),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: _buildInfoBox(_reps.toString(), controllerReps),
                        ),
                      ],
                    ),
                  ),
                  // Descanso
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Descanso:"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: _buildInfoBox(_rest.toString(), controllerRest),
                            ),
                            const SizedBox(width: 5),
                            const Text("segundos"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Botão adicionar
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('clicou');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.primaryColor1,
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
      ),
    );
  }

  // Função para construir os valores das caixas de séries, repetições e descanso
  Widget _buildInfoBox(String value, TextEditingController controller) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: value,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
      ),
    );
  }
}
