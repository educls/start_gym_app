import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionaryView(
        questions: [
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
          DateQuestion(type: QuestionType.smoke),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class QuestionaryView extends StatefulWidget {
  List<IQuestion> questions;

  QuestionaryView({super.key, required this.questions});

  @override
  State<QuestionaryView> createState() => _QuestionaryViewState();
}

class _QuestionaryViewState extends State<QuestionaryView> {
  int _actualQuestion = 0;

  List<QuestionModel> _questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questionário"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Questao: ${_actualQuestion + 1}"),
            const SizedBox(height: 10),
            widget.questions[_actualQuestion].buildQuestion(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (widget.questions.length == _actualQuestion) {
                  submitQuestionary();
                  return;
                }

                addResponse(
                    widget.questions[_actualQuestion].getQuestionValue());

                setState(() {
                  if (mounted) {
                    _actualQuestion++;
                  }
                });
              },
              child: const Text("Próxima pergunta"),
            ),
          ],
        ),
      ),
    );
  }

  submitQuestionary() {}

  addResponse(QuestionModel response) {
    _questions.add(response);
  }
}

abstract interface class IQuestion {
  Widget buildQuestion();
  QuestionModel getQuestionValue();
}

class DateQuestion implements IQuestion {
  final QuestionType type;

  DateQuestion({required this.type});

  @override
  Widget buildQuestion() {
    return DatePickerDialog(
      firstDate: DateTime(2050),
      lastDate: DateTime(1910),
    );
  }

  @override
  QuestionModel getQuestionValue() {
    return QuestionModel(text: "_controller.text", type: type);
  }
}

class FloatQuestion implements IQuestion {
  final QuestionType type;
  final String hintText;
  final TextEditingController _controller = TextEditingController();

  FloatQuestion({required this.hintText, required this.type});

  @override
  Widget buildQuestion() {
    return TextField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(hintText: hintText),
    );
  }

  @override
  QuestionModel getQuestionValue() {
    return QuestionModel(text: _controller.text, type: type);
  }
}

enum QuestionType {
  weigth,
  height,
  smoke,
}

class QuestionModel {
  String text;
  QuestionType type;

  QuestionModel({required this.text, required this.type});
}
