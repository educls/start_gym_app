import 'dart:async';
import 'package:flutter/material.dart';
import 'package:start_gym_app/widgets/custom_gray_text.dart';
import 'package:start_gym_app/widgets/inputs/custom_input_field_login.dart';

import '../../common_widget/round_button.dart';
import '../../functions/login/login_functions.dart';
import '../../mixin/login_state_mixin.dart';
import '../login/custom_row_remember_forgot.dart';
import '../login/custom_show_blocked_account.dart';

class BuildLoginForm extends StatefulWidget {
  final bool isLoading;
  final Function setLoading;
  final Function toggleForm;
  const BuildLoginForm({
    super.key,
    required this.isLoading,
    required this.setLoading,
    required this.toggleForm,
  });

  @override
  State<BuildLoginForm> createState() => _BuildLoginFormState();
}

class _BuildLoginFormState extends State<BuildLoginForm> with LoginStateHelpers<BuildLoginForm> {

  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? const Center() : buidForm();
  }

  Widget buidForm() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Container(
          constraints: const BoxConstraints(minHeight: 50),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bem Vindo",
                  style: TextStyle(
                    color: Color.fromRGBO(31, 35, 115, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const CustomGrayText(text: "Realizar Login"),
                const SizedBox(height: 20),
                const CustomGrayText(text: "Email"),
                CustomInputFieldLogin(controller: emailController, isPassword: false),
                const SizedBox(height: 20),
                const CustomGrayText(text: "Senha"),
                CustomInputFieldLogin(controller: passwordController, isPassword: true),
                SizedBox(height: attempts < 5 ? 0 : 20),
                CustomShowBlockedAccount(attempts: attempts),
                CustomGrayText(text: attempts == 5 ? 'Desbloqueio em: $remainingTimeInSecondsBlock segundos' : ''),
                SizedBox(height: attempts < 5 ? 0 : 20),
                CustomRememberForgot(
                  rememberUser: rememberUser,
                  setRememberUser: setRememberUser,
                  toggleForm: widget.toggleForm,
                  attempts: attempts,
                ),
                const SizedBox(height: 20),
                _buildRoundLoginButton(),
                const SizedBox(height: 60),
                // _buildRoundSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundLoginButton() {
    return RoundButton(
      width: 330,
      isLoading: isLoading,
      title: "LOGIN",
      onPressed: remainingTimeInSecondsBlock == 60 || remainingTimeInSecondsBlock == 0
          ? () async {
              widget.setLoading(true);
              await Future.delayed(const Duration(milliseconds: 500));
              //Classe que executa toda a logica de LOGIN
              await LoginFunctions(
                // context: context,
                emailController: emailController,
                // passwordController: passwordController,
                // rememberUser: rememberUser,
                setLoading: widget.setLoading,
                // attempts: attempts,
                // startTimer: startTimer,
                // setAttempts: setAttempts,
              ).onPressedForLoginButton(context);
            }
          : () {
              null;
            },
    );
  }
}
