import 'package:flutter/material.dart';

import '../../utils/constants/color_constants.dart';
import '../../utils/constants/path_contants.dart';
import '../../utils/enums/questionary_roles.dart';
import 'custom_option_questionary.dart';

class QuestionaryPicker extends StatelessWidget {
  const QuestionaryPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: ColorConstants.blue,
      ),
      width: media.width * 1,
      height: media.height * 0.288,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionQuestionary(
                text: 'Avaliação física',
                type: TypeQuestionary.avaliacao_fisica,
                pathIconImage: PathConstants.avalFisica,
              ),
              OptionQuestionary(
                text: 'Histórico de atividades',
                type: TypeQuestionary.historico_atividades,
                pathIconImage: PathConstants.histActivity,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionQuestionary(
                text: 'Histórico de doenças',
                type: TypeQuestionary.historico_doencas,
                pathIconImage: PathConstants.histDesease,
              ),
              OptionQuestionary(
                text: 'Minha evolução',
                type: TypeQuestionary.minha_evolucao,
                pathIconImage: PathConstants.myEvolution,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
