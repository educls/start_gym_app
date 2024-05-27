import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:start_gym_app/utils/provider/data_provider.dart';

import '../../controllers/users/users_controller.dart';
import '../../utils/enums/questionary_roles.dart';

class SendImageListMinhaEvolucaoHelper {
  final BuildContext context;
  final DataAppProvider value;
  final List<String?> base64Images;
  final Function setLoading;
  final TypeQuestionary type;

  const SendImageListMinhaEvolucaoHelper({
    required this.context,
    required this.value,
    required this.base64Images,
    required this.setLoading,
    required this.type,
  });

  Future<void> onPressedForSendImageListMinhaEvolucao() async {
    setLoading(true);
    sendImageListMinhaEvolucao(value.token, base64Images, type);
    await Future.delayed(const Duration(milliseconds: 1000));
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Images Enviadas',
      disableBackBtn: true,
      barrierDismissible: false,
      confirmBtnText: 'Ok',
      onConfirmBtnTap: () {
        setLoading(false);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}

class QuestionaryHelper {
  final BuildContext context;
  final Function setLoading;
  final DataAppProvider value;
  final TypeQuestionary type;
  final Map<String, dynamic> questionsMap;

  const QuestionaryHelper({
    required this.context,
    required this.setLoading,
    required this.value,
    required this.type,
    required this.questionsMap,
  });

  Future<void> onPressedForSendQuestionary() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1000));
    sendQuestionaryToApi(value.token, questionsMap, type);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Questionário Finalizado',
      disableBackBtn: true,
      barrierDismissible: false,
      confirmBtnText: 'Ok',
      onConfirmBtnTap: () {
        setLoading(false);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
