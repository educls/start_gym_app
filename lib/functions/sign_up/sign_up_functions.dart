import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';
import '../../controllers/users/users_controller.dart';

class SignUpFunctions {
  final BuildContext context;
  final String base64Image;
  final TextEditingController txtName;
  final TextEditingController txtNumero;
  final TextEditingController txtEmail;
  final TextEditingController txtPassword;
  final TextEditingController txtConfirmPassword;
  final Function setLoading;
  final bool waitingConfirmationEmail;

  const SignUpFunctions({
    required this.context,
    required this.base64Image,
    required this.txtName,
    required this.txtNumero,
    required this.txtEmail,
    required this.txtPassword,
    required this.txtConfirmPassword,
    required this.setLoading,
    required this.waitingConfirmationEmail,
  });

  Future<void> saveCredentialsForSignUpAndEmailConfirmation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photoSignUp', base64Image);
    prefs.setString('nameSignUp', txtName.text);
    prefs.setString('numberSignUp', txtNumero.text);
    prefs.setString('emailSignUp', txtEmail.text);
    prefs.setString('passwordSignUp', txtPassword.text);
    prefs.setString('passwordConfirmSignUp', txtConfirmPassword.text);
    prefs.setBool('waitingConfirmation', true);
  }

  Future<void> deleteCredentialsForSignUpAndEmailConfirmation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('photoSignUp');
    await prefs.remove('nameSignUp');
    await prefs.remove('numberSignUp');
    await prefs.remove('emailSignUp');
    await prefs.remove('passwordSignUp');
    await prefs.remove('passwordConfirmSignUp');
    await prefs.remove('waitingConfirmation');
  }

  Future<void> onPressedForSignUpButton(BuildContext context) async {
    String photoPerfilBase64Encode = base64Image;
    String name = txtName.text;
    String numWhats = txtNumero.text;
    String email = txtEmail.text;
    String password = txtPassword.text;
    String confirmPassword = txtConfirmPassword.text;

    if (waitingConfirmationEmail == false) {
      if (name.isEmpty ||
          numWhats.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'Alguns Campos estão vazios',
          confirmBtnText: 'Ok',
          title: 'Aviso',
          confirmBtnColor: TColor.primaryColor1,
          onConfirmBtnTap: () {
            setLoading(false);
            Navigator.pop(context);
          },
        );
      } else if (password != confirmPassword) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'As senhas não conferem',
          confirmBtnText: 'Ok',
          title: 'Aviso',
          confirmBtnColor: TColor.primaryColor1,
          onConfirmBtnTap: () {
            setLoading(false);
            Navigator.pop(context);
          },
        );
      } else {
        sendEmailForVerifiedEmail(txtEmail.text);
        await Future.delayed(const Duration(milliseconds: 500));
        bool status = await waitForEmailVerified();
        await Future.delayed(const Duration(milliseconds: 700));
        await deleteCredentialsForSignUpAndEmailConfirmation();
        if (status == true) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Cadastro Realizado com Sucesso!',
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
    } else {
      if (waitingConfirmationEmail == false) {
        sendEmailForVerifiedEmail(txtEmail.text);
      }
      await Future.delayed(const Duration(milliseconds: 500));
      bool status = await waitForEmailVerified();
      await Future.delayed(const Duration(milliseconds: 700));
      await deleteCredentialsForSignUpAndEmailConfirmation();
      if (status == true) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Cadastro Realizado com Sucesso!',
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
  }

  Future<bool> waitForEmailVerified() async {
    bool receivedData = false;
    late http.Response response;
    late dynamic body;

    await saveCredentialsForSignUpAndEmailConfirmation();

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Aguardando',
      text: 'Confirmação de Email \n ${txtEmail.text}',
      showCancelBtn: true,
      cancelBtnText: 'Cancelar',
      onCancelBtnTap: () async {
        await deleteEmailIsAboutVerified(txtEmail.text);
        Navigator.pop(context);
        receivedData = true;
        deleteCredentialsForSignUpAndEmailConfirmation();
        setLoading(false);
      },
      barrierDismissible: false,
      disableBackBtn: true,
    );

    while (!receivedData) {
      await Future.delayed(const Duration(milliseconds: 5000));
      response = await checkIfEmailIsVerified(txtEmail.text);
      body = json.decode(response.body);

      if (body['mensagem'] == true) {
        receivedData = true;
        if (body['status'] == true) {
          Navigator.pop(context);
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Email foi confirmado com sucesso!',
            disableBackBtn: true,
            barrierDismissible: false,
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
          );
          return true;
        }
      }
    }
    return false;
  }
}
