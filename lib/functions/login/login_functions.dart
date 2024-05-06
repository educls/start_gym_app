import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:quickalert/quickalert.dart';

import '../../common/color_extension.dart';
import '../../controllers/users/users_controller.dart';
import '../../utils/provider/data_provider.dart';

class LoginFunctions {
  final BuildContext context;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberUser;
  final Function setLoading;
  final int attempts;
  final Function startTimer;
  final Function setAttempts;
  final Function saveCredentialsAndPreferences;

  const LoginFunctions({
    required this.context,
    required this.emailController,
    required this.passwordController,
    required this.rememberUser,
    required this.setLoading,
    required this.attempts,
    required this.startTimer,
    required this.setAttempts,
    required this.saveCredentialsAndPreferences,
  });

  Future<void> onPressedForLoginButton(BuildContext context) async {
    final value = Provider.of<DataAppProvider>(context, listen: false);

    // Envia a requisicao de LOGIN para a API e armazena a resposta a ser
    // tratata pelo app
    late http.Response response;
    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      response = await userLogin(emailController.text, passwordController.text);
      print(response.body);
    }

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Alguns campos estão vazios',
        confirmBtnText: 'Ok',
        title: 'Aviso',
        confirmBtnColor: TColor.darkYellow,
      );
    } else if (response.statusCode == 401) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      var body = json.decode(response.body);
      setAttempts(body['tentativas']);
      if (body['tentativas'] == 5) {
        startTimer();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: '${body['mensagem']}',
          confirmBtnText: 'Ok',
          title: 'Bloqueado Temporariamente!',
          confirmBtnColor: TColor.darkYellow,
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: body['tentativas'] >= 3
              ? '${body['mensagem']}\n${5 - body['tentativas']} tentativas até o bloqueio temporário'
              : '${body['mensagem']}',
          confirmBtnText: 'Ok',
          title: 'Aviso',
          confirmBtnColor: TColor.darkYellow,
        );
      }
    } else {
      if (rememberUser) {
        saveCredentialsAndPreferences();
      }
      await Future.delayed(const Duration(milliseconds: 300));
      setAttempts(0);
      var body = json.decode(response.body);
      value.setToken(body["token"]);
      setLoading(false);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    }
  }
}
