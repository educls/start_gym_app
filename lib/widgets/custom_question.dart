import 'package:flutter/material.dart';

import '../common_widget/round_button.dart';
import '../utils/constants/questions_constants.dart';
import 'custom_question_checkbox.dart';
import 'custom_question_text_field.dart';

// ignore: must_be_immutable
class Pergunta extends StatelessWidget {
  final String pergunta;
  final Map<String, dynamic> questionsMap;
  final Function(String) onRespostaSelecionada;
  final Function setSelectedChoicesQuestions;
  final Function nextQuestion;
  final Function previousQuestion;
  final TextEditingController respostaController;

  Pergunta({
    super.key,
    required this.pergunta,
    required this.questionsMap,
    required this.nextQuestion,
    required this.previousQuestion,
    required this.onRespostaSelecionada,
    required this.setSelectedChoicesQuestions,
    required this.respostaController,
  });

  TextEditingController resposta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currentQuestionValue = questionsMap[pergunta];
    bool isIntValue = currentQuestionValue is double;
    bool isStringValue = currentQuestionValue is String;
    bool isDateValue = currentQuestionValue is DateTime;
    bool isChoiceList = currentQuestionValue is List<Choice>;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            pergunta,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.all(40),
          child: isChoiceList
              ? CustomCheckBoxList(
                  currentQuestionValue: currentQuestionValue,
                  setSelectedChoicesQuestions: setSelectedChoicesQuestions,
                )
              : CustomTextField(
                  isIntValue: isIntValue,
                  isStringValue: isStringValue,
                  isDateValue: isDateValue,
                  pergunta: pergunta,
                  respostaController: resposta,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundButton(
                width: 130,
                title: 'Anterior',
                onPressed: () async {
                  previousQuestion();
                },
              ),
              RoundButton(
                width: 130,
                title: 'Próxima',
                onPressed: () async {
                  if (isChoiceList) {
                    // Pegar escolhas selecionadas
                    // List<Choice> selectedChoices = (currentQuestionValue).where((choice) => choice.isSelected).toList();
                    nextQuestion();
                  } else {
                    onRespostaSelecionada(resposta.text);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
