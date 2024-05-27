import 'package:flutter/material.dart';

import '../custom_gray_text.dart';

class CustomRememberForgot extends StatefulWidget {
  final bool rememberUser;
  final Function setRememberUser;
  final Function toggleForm;
  final int attempts;
  const CustomRememberForgot({
    super.key,
    required this.rememberUser,
    required this.setRememberUser,
    required this.toggleForm,
    required this.attempts,
  });

  @override
  State<CustomRememberForgot> createState() => _CustomRememberForgotState();
}

class _CustomRememberForgotState extends State<CustomRememberForgot> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.rememberUser,
              onChanged: (value) {
                widget.setRememberUser(value!);
              },
              activeColor: const Color.fromRGBO(50, 56, 230, 1), // Definindo a cor azul para o Checkbox
            ),
            const CustomGrayText(text: "Lembrar-me")
          ],
        ),
        TextButton(
          onPressed: widget.attempts < 5
              ? () {
                  widget.toggleForm();
                }
              : () {},
          child: const CustomGrayText(text: "Esqueci Minha Senha"),
        )
      ],
    );
  }
}
