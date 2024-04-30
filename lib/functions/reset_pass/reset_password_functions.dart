import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import '../../controllers/users/users_controller.dart';
import '../../common/color_extension.dart';

class ResetPasswordFunctions {
  final BuildContext context;
  final TextEditingController emailController;
  final Function startTimerForResetPassword;
  final Function setEmailSend;
  final Function setLoading;

  const ResetPasswordFunctions(
      {required this.context,
      required this.emailController,
      required this.startTimerForResetPassword,
      required this.setEmailSend,
      required this.setLoading});

  Future<void> onPressedForSendEmailResetPasswordButton(
      BuildContext context) async {
    // Envia a requisicao do Envio de email para a API e armazena a resposta
    //a ser tratata pelo app
    http.Response response =
        await userSendEmailForResetPassword(emailController.text);

    if (response.statusCode == 200) {
      startTimerForResetPassword();
      setEmailSend(true);
    }

    if (emailController.text.isEmpty || response.statusCode == 401) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Email não Encontrado',
        confirmBtnText: 'Ok',
        title: 'Aviso',
        confirmBtnColor: TColor.primaryColor1,
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: emailController.text,
        confirmBtnText: 'Ok',
        title: 'Email enviado para: ',
      );
    }
  }
}
