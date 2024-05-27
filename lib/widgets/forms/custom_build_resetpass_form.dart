import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../common_widget/round_button.dart';
import '../../functions/reset_pass/reset_password_functions.dart';
import '../../mixin/login_state_mixin.dart';
import '../custom_gray_text.dart';
import '../inputs/custom_input_field_login.dart';

class BuildResetPassForm extends StatefulWidget {
  final Function toggleForm;
  final Function setLoading;
  final bool isLoading;
  const BuildResetPassForm({
    super.key,
    required this.toggleForm,
    required this.setLoading,
    required this.isLoading,
  });

  @override
  State<BuildResetPassForm> createState() => _BuildResetPassFormState();
}

class _BuildResetPassFormState extends State<BuildResetPassForm> with LoginStateHelpers<BuildResetPassForm> {
  // Conteudo da tela ESQUECI MINHA SENHA
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
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.toggleForm();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Recuperar Senha",
                          style: TextStyle(
                            color: Color.fromRGBO(31, 35, 115, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    const Row(children: [CustomGrayText(text: "Email")]),
                    CustomInputFieldLogin(controller: emailController, isPassword: false),
                    const SizedBox(height: 40),
                    CustomGrayText(
                      text: emailSend == true ? 'Enviar Novamente em: $remainingTimeInSeconds segundos' : '',
                    ),
                    const SizedBox(height: 10),
                    _buildRoundResetPassButton(),
                    const SizedBox(height: 120)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundResetPassButton() {
    return RoundButton(
      width: 330,
      title: 'ENVIAR',
      isLoading: isLoading,
      onPressed: emailSend == false
          ? () async {
              widget.setLoading(true);
              // Logica para o envio do email com
              // a Redefinição da Senha
              ResetPasswordFunctions(
                context: context,
                emailController: emailController,
                startTimerForResetPassword: startTimerForResetPassword,
                setEmailSend: setEmailSend,
                setLoading: widget.setLoading,
              ).onPressedForSendEmailResetPasswordButton();
            }
          : () {
              null;
            },
    );
  }
}
