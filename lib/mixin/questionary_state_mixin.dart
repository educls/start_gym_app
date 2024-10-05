import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/questionary/questionary_helper.dart';
import '../utils/enums/questionary_roles.dart';
import '../utils/provider/data_provider.dart';

mixin QuestionaryStateHelper<T extends StatefulWidget> on State<T> {
  final TextEditingController respostaController = TextEditingController();

  late bool? firstTime;

  DateTime selectedDate = DateTime.now();

  late TypeQuestionary type;

  late Map<String, dynamic> questionsMap = {};

  late int totalPerguntas;

  int indicePergunta = 0;
  double progresso = 0.0;

  List<String?> base64Images = List.filled(3, null);

  void setBase64ImageList(int index, String base64Image) {
    setState(() {
      base64Images[index] = base64Image;
    });
  }

  bool isLoading = false;
  void setLoading(bool setLoading) {
    setState(() {
      isLoading = setLoading;
    });
  }

  void nextQuestion() async {
    setState(() {
      respostaController.clear();
      indicePergunta++;
      progresso = (indicePergunta / totalPerguntas) * 100;
    });
    if (indicePergunta == totalPerguntas) {
      // QuestionaryHelper(
      //   context: context,
      //   setLoading: setLoading,
      //   value: Provider.of<DataAppProvider>(context, listen: false),
      //   type: type,
      //   questionsMap: questionsMap,
      // ).onPressedForSendQuestionary();
    }
  }

  void previousQuestion() async {
    if (indicePergunta != 0) {
      setState(() {
        respostaController.clear();
        indicePergunta--;
        progresso = (indicePergunta / totalPerguntas) * 100;
      });
    }
  }

  void proximaPergunta(String resposta) {
    // print(resposta);
    setState(() {
      questionsMap[questionsMap.keys.elementAt(indicePergunta)] = resposta;
      nextQuestion();
    });
  }

  void setSelectedChoicesQuestions(String key, bool value, int index) {
    setState(() {
      questionsMap[questionsMap.keys.elementAt(indicePergunta)][index].isSelected = value;
    });
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        print(selectedDate);
        selectedDate = picked;
      });
    }
  }
}
