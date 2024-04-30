import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickalert/quickalert.dart';
import '../../common/color_extension.dart';
import '../../controllers/users/users_controller.dart';
import '../shared_preferences/shared_preferences_functions.dart';

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

  Future<void> onPressedForSignUpButton(BuildContext context) async {
    String accountType = 'aluno';
    String photoBase64 = base64Image;
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
        http.Response response = await sendEmailForVerifiedEmail(txtEmail.text);
        print(response.statusCode);
        registerUserAfterVerifiedEmail(
          accountType,
          photoBase64,
          name,
          numWhats,
          email,
          password,
        );
      }
    } else {
      registerUserAfterVerifiedEmail(
        accountType,
        photoBase64,
        name,
        numWhats,
        email,
        password,
      );
    }
  }

  void registerUserAfterVerifiedEmail(
    accountType,
    photoBase64,
    name,
    numWhats,
    email,
    password,
  ) async {
    bool status = await waitForEmailVerified();
    await Future.delayed(const Duration(milliseconds: 700));
    SharedPreferencesFunctions()
        .deleteCredentialsForSignUpAndEmailConfirmation();
    if (status == true) {
      http.Response resp = await userSignUp(
          accountType, photoBase64, name, numWhats, email, password);
      if (resp.statusCode == 201) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Sucesso',
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
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erro',
          disableBackBtn: true,
          barrierDismissible: false,
          text: 'Ao Realizar cadastro!',
          confirmBtnText: 'Ok',
          onConfirmBtnTap: () {
            setLoading(false);
            deleteEmailIsAboutVerified(txtEmail.text);
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

    SharedPreferencesFunctions().saveCredentialsForSignUpAndEmailConfirmation(
      base64Image,
      txtName,
      txtNumero,
      txtEmail,
      txtPassword,
      txtConfirmPassword,
      true,
    );

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Aguardando',
      text:
          'Email de confirmação enviado para:\n ${txtEmail.text}\n Verifique seu email',
      showCancelBtn: true,
      cancelBtnText: 'Cancelar',
      onCancelBtnTap: () async {
        await deleteEmailIsAboutVerified(txtEmail.text);
        Navigator.pop(context);
        receivedData = true;
        SharedPreferencesFunctions()
            .deleteCredentialsForSignUpAndEmailConfirmation();
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
            title: 'Sucesso',
            text: 'Email foi confirmado com sucesso!',
            disableBackBtn: true,
            barrierDismissible: false,
            onConfirmBtnTap: () {
              Navigator.pop(context);
              deleteEmailIsAboutVerified(txtEmail.text);
            },
          );
          return body['status'];
        }
      }
    }
    return false;
  }
}
