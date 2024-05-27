import 'package:flutter/material.dart';

import '../../mixin/questionary_state_mixin.dart';
import '../../utils/constants/questions_constants.dart';
import '../../utils/enums/questionary_roles.dart';
import '../custom_question.dart';

class CustomFormQuestionary extends StatefulWidget {
  final TypeQuestionary type;
  const CustomFormQuestionary({
    super.key,
    required this.type,
  });

  @override
  State<CustomFormQuestionary> createState() => _CustomFormQuestionaryState();
}

class _CustomFormQuestionaryState extends State<CustomFormQuestionary> with QuestionaryStateHelper<CustomFormQuestionary> {

  @override
  void initState() {
    super.initState();
    type = widget.type;
    switch (type) {
      case TypeQuestionary.avaliacao_fisica:
        questionsMap = Questionary.getInitialAvalFisica();
        break;
      case TypeQuestionary.historico_atividades:
        questionsMap = Questionary.getInitialHistAtividades();
        break;
      case TypeQuestionary.historico_doencas:
        questionsMap = Questionary.getInitialHistDoencas();
        break;
      case TypeQuestionary.minha_evolucao:
        questionsMap = Questionary.getInitialEvolucao();
        break;
      default:
    }
    totalPerguntas = questionsMap.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.all(25),
          child: Column(
            children: [
              Text(
                '${((progresso.floor() / 100) * 100).truncate()}%',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LinearProgressIndicator(
                value: progresso / 100,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                borderRadius: BorderRadius.circular(20),
                minHeight: 40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        indicePergunta < totalPerguntas
            ? Pergunta(
                pergunta: questionsMap.keys.elementAt(indicePergunta),
                questionsMap: questionsMap,
                respostaController: respostaController,
                onRespostaSelecionada: proximaPergunta,
                setSelectedChoicesQuestions: setSelectedChoicesQuestions,
                nextQuestion: nextQuestion,
                previousQuestion: previousQuestion,
              )
            : const Text(
                'Questionário concluído!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
