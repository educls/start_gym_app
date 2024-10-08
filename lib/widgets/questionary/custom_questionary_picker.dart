import 'package:flutter/material.dart';

import '../../utils/constants/color_constants.dart';
import '../../utils/constants/path_contants.dart';
import '../../utils/enums/questionary_roles.dart';
import 'custom_option_questionary.dart';

class QuestionaryPicker extends StatelessWidget {
  const QuestionaryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          color: ColorConstants.darkBlue,
        ),
        width: media.width,
        height: media.height * 0.26, // Ajuste a altura se necessário
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              right: 32,
              left: 20), // Aumente este valor conforme necessário
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16), // Aumente este valor para mais espaço
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OptionQuestionary(
                      text: 'Avaliação física',
                      type: TypeQuestionary.avaliacao_fisica,
                      pathIconImage: PathConstants.avalFisica,
                    ),
                  ),
                  Expanded(
                    child: OptionQuestionary(
                      text: 'Histórico de atividades',
                      type: TypeQuestionary.historico_atividades,
                      pathIconImage: PathConstants.histActivity,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OptionQuestionary(
                      text: 'Histórico de doenças',
                      type: TypeQuestionary.historico_doencas,
                      pathIconImage: PathConstants.histDesease,
                    ),
                  ),
                  Expanded(
                    child: OptionQuestionary(
                      text: 'Minha evolução',
                      type: TypeQuestionary.minha_evolucao,
                      pathIconImage: PathConstants.myEvolution,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
