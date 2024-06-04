import 'package:flutter/material.dart';

import '../../utils/constants/tittle_questionary.dart';
import '../../utils/enums/questionary_roles.dart';
import '../../widgets/forms/custom_form_my_evolution.dart';
import '../../widgets/forms/custom_form_questionary.dart';

class QuestionaryPage extends StatefulWidget {
  final TypeQuestionary type;
  const QuestionaryPage({
    super.key,
    required this.type,
  });

  @override
  State<QuestionaryPage> createState() => _QuestionaryPageState();
}

class _QuestionaryPageState extends State<QuestionaryPage> {
  bool isLoading = false;
  void setLoading(bool setLoading) {
    setState(() {
      isLoading = setLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.type == TypeQuestionary.minha_evolucao
                  ? CustomFormMyEvolution(type: widget.type, setLoading: setLoading)
                  : CustomFormQuestionary(type: widget.type),
        ],
      ),
    );
  }

  // Widget buildFormToPickImage() {
  //   var media = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: SingleChildScrollView(
  //         child: Column(children: [
  //           Wrap(
  //             spacing: 8.0,
  //             runSpacing: 8.0,
  //             children: List.generate(base64Images.length, (index) {
  //               return GestureDetector(
  //                 onTap: () => showPickerDialog((base64) => setBase64ImageList(index, base64)),
  //                 child: Container(
  //                   width: media.width * 0.47,
  //                   height: media.height * 0.3,
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: base64Images[index] == null
  //                       ? const Center(child: Text('Adicionar foto'))
  //                       : Image.memory(
  //                           base64Decode(base64Images[index]!),
  //                           fit: BoxFit.cover,
  //                           width: double.infinity,
  //                           height: double.infinity,
  //                         ),
  //                 ),
  //               );
  //             }),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 60),
  //             child: RoundButton(
  //               width: 330,
  //               title: 'Enviar',
  //               onPressed: () async {
  //                 SendImageListMinhaEvolucaoHelper(
  //                   context: context,
  //                   value: Provider.of<DataAppProvider>(context, listen: false),
  //                   base64Images: base64Images,
  //                   setLoading: setLoading,
  //                   type: type,
  //                 ).onPressedForSendImageListMinhaEvolucao();
  //               },
  //             ),
  //           ),
  //         ]),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildQuestionary() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsetsDirectional.all(25),
  //         child: Column(
  //           children: [
  //             Text(
  //               '${((progresso.floor() / 100) * 100).truncate()}%',
  //               style: const TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             LinearProgressIndicator(
  //               value: progresso / 100,
  //               backgroundColor: Colors.grey[300],
  //               valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
  //               borderRadius: BorderRadius.circular(20),
  //               minHeight: 40,
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 20),
  //       indicePergunta < totalPerguntas
  //           ? Pergunta(
  //               pergunta: questionsMap.keys.elementAt(indicePergunta),
  //               questionsMap: questionsMap,
  //               respostaController: respostaController,
  //               onRespostaSelecionada: proximaPergunta,
  //               setSelectedChoicesQuestions: setSelectedChoicesQuestions,
  //               nextQuestion: nextQuestion,
  //               pickDate: pickDate,
  //               selectedDate: selectedDate,
  //             )
  //           : const Text(
  //               'Questionário concluído!',
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //     ],
  //   );
  // }
}
