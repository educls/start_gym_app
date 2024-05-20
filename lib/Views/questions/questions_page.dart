import 'dart:convert';
import 'dart:ffi';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:start_gym_app/controllers/users/users_controller.dart';
import 'package:start_gym_app/functions/questionary/questionary_helper.dart';

import '../../common_widget/round_button.dart';
import '../../functions/sign_up/pick_img_perfil.dart';
import '../../utils/constants/questions_constants.dart';
import '../../utils/provider/data_provider.dart';
import '../home/edit_info_user_page.dart';

enum TypeQuestionary { avalFisica, histAtividades, histDoencas, minhaEvolucao }

class QuestionarioWidget extends StatefulWidget {
  final TypeQuestionary type;
  const QuestionarioWidget({
    super.key,
    required this.type,
  });

  @override
  State<QuestionarioWidget> createState() => _QuestionarioWidgetState();
}

class _QuestionarioWidgetState extends State<QuestionarioWidget> {
  late TypeQuestionary type;
  DataAppProvider? value;

  late Map<String, dynamic> questionsMap = {};
  late int _totalPerguntas;

  @override
  void initState() {
    super.initState();
    type = widget.type;
    switch (type) {
      case TypeQuestionary.avalFisica:
        questionsMap = Questionary.getInitialAvalFisica();
        break;
      case TypeQuestionary.histAtividades:
        questionsMap = Questionary.getInitialHistAtividades();
        break;
      case TypeQuestionary.histDoencas:
        questionsMap = Questionary.getInitialHistDoencas();
        break;
      case TypeQuestionary.minhaEvolucao:
        questionsMap = Questionary.getInitialEvolucao();
        break;
      default:
    }

    _totalPerguntas = questionsMap.length;
  }

  @override
  void dispose() {
    questionsMap = {};
    super.dispose();
  }

  void initProvider() {
    value = context.watch<DataAppProvider>();
  }

  int _indicePergunta = 0;
  double _progresso = 0.0;

  final TextEditingController _respostaController = TextEditingController();

  void setSelectedChoicesQuestions(String key, bool value, int index) {
    setState(() {
      questionsMap[questionsMap.keys.elementAt(_indicePergunta)][index]
          .isSelected = value;
    });
  }

  void _proximaPergunta(String resposta) {
    bool isChoiceList = questionsMap[resposta] is List<Choice>;
    setState(() {
      questionsMap[questionsMap.keys.elementAt(_indicePergunta)] = resposta;
      nextQuestion();
    });
  }

  void nextQuestion() async {
    setState(() {
      _respostaController.clear();
      _indicePergunta++;
      _progresso = (_indicePergunta / _totalPerguntas) * 100;
    });
    if (_indicePergunta == _totalPerguntas) {
      QuestionaryHelper(
              context: context,
              setLoading: setLoading,
              value: value!,
              type: type,
              questionsMap: questionsMap)
          .onPressedForSendQuestionary();
    }
  }

  bool _isLoading = false;
  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  List<String?> base64Images = List.filled(3, null);

  void setBase64Image(int index, String base64Image) {
    setState(() {
      base64Images[index] = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      initProvider();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: type == TypeQuestionary.minhaEvolucao
            ? const Text('Evolução')
            : const Text('Questionário'),
      ),
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : type == TypeQuestionary.minhaEvolucao
                  ? buildFormToPickImage()
                  : buildQuestionary(),
        ],
      ),
    );
  }

  Widget buildFormToPickImage() {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(base64Images.length, (index) {
                return GestureDetector(
                  onTap: () => showChoiceForSetPhoto(index),
                  child: Container(
                    width: media.width * 0.47,
                    height: media.height * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: base64Images[index] == null
                        ? const Center(child: Text('Adicionar foto'))
                        : Image.memory(
                            base64Decode(base64Images[index]!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: RoundButton(
                width: 330,
                title: 'Enviar',
                onPressed: () async {
                  SendImageListMinhaEvolucaoHelper(
                          context: context,
                          value: value!,
                          base64Images: base64Images,
                          setLoading: setLoading,
                          type: type)
                      .onPressedForSendImageListMinhaEvolucao();
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void showChoiceForSetPhoto(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Escolha uma opção',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    PickImgFunction(
                      context: context,
                      setImgFile: (file) {},
                      setBase64Image: (base64) => setBase64Image(index, base64),
                    ).pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.photo_library,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    PickImgFunction(
                      context: context,
                      setImgFile: (file) {},
                      setBase64Image: (base64) => setBase64Image(index, base64),
                    ).pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget buildQuestionary() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.all(25),
          child: Column(
            children: [
              Text(
                '${((_progresso.floor() / 100) * 100).truncate()}%',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LinearProgressIndicator(
                value: _progresso / 100,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                borderRadius: BorderRadius.circular(20),
                minHeight: 40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _indicePergunta < _totalPerguntas
            ? Pergunta(
                pergunta: questionsMap.keys.elementAt(_indicePergunta),
                questionsMap: questionsMap,
                respostaController: _respostaController,
                onRespostaSelecionada: _proximaPergunta,
                setSelectedChoicesQuestions: setSelectedChoicesQuestions,
                nextQuestion: nextQuestion,
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

class Pergunta extends StatelessWidget {
  final String pergunta;
  final Map<String, dynamic> questionsMap;
  final Function(String) onRespostaSelecionada;
  final Function setSelectedChoicesQuestions;
  final Function nextQuestion;
  final TextEditingController respostaController;

  const Pergunta({
    required this.pergunta,
    required this.questionsMap,
    required this.nextQuestion,
    required this.onRespostaSelecionada,
    required this.setSelectedChoicesQuestions,
    required this.respostaController,
  });

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
          padding: EdgeInsets.only(left: 15, right: 15),
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
              ? Column(
                  children: (currentQuestionValue as List<Choice>)
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                    int index = entry.key;
                    Choice choice = entry.value;
                    return CheckboxListTile(
                      title: Text(choice.title),
                      value: choice.isSelected,
                      onChanged: (bool? value) {
                        setSelectedChoicesQuestions(
                            choice.title, value ?? false, index);
                      },
                    );
                  }).toList(),
                )
              : TextField(
                  inputFormatters: isStringValue
                      ? []
                      : [
                          FilteringTextInputFormatter.digitsOnly,
                          pergunta == 'Peso'
                              ? PesoInputFormatter()
                              : pergunta == 'Altura'
                                  ? AlturaInputFormatter()
                                  : DataInputFormatter()
                        ],
                  keyboardType: isIntValue
                      ? TextInputType.number
                      : isStringValue
                          ? TextInputType.multiline
                          : isDateValue
                              ? TextInputType.datetime
                              : null,
                  maxLines: isStringValue ? null : 1,
                  controller: respostaController,
                  textAlign: isStringValue ? TextAlign.left : TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua resposta...',
                  ),
                ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     if (isChoiceList) {
        //       // Pegar escolhas selecionadas
        //       List<Choice> selectedChoices = (currentQuestionValue)
        //           .where((choice) => choice.isSelected)
        //           .toList();
        //       print(selectedChoices);
        //       nextQuestion();
        //     } else {
        //       onRespostaSelecionada(respostaController.text);
        //     }
        //   },
        //   child: const Text('Próxima'),
        // ),
        RoundButton(
          width: 330,
          title: 'Próxima',
          onPressed: () async {
            if (isChoiceList) {
              // Pegar escolhas selecionadas
              List<Choice> selectedChoices = (currentQuestionValue)
                  .where((choice) => choice.isSelected)
                  .toList();
              print(selectedChoices);
              nextQuestion();
            } else {
              onRespostaSelecionada(respostaController.text);
            }
          },
        ),
      ],
    );
  }
}
