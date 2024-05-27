import 'package:flutter/material.dart';

class CustomInputFieldLogin extends StatefulWidget {
  final bool isPassword;
  final TextEditingController controller;
  const CustomInputFieldLogin({
    super.key,
    required this.controller,
    required this.isPassword,
  });

  @override
  State<CustomInputFieldLogin> createState() => _CustomInputFieldLoginState();
}

class _CustomInputFieldLoginState extends State<CustomInputFieldLogin> {

  bool isObscurePassword = true;
  void setObscure(bool isObscure) {
    setState(() {
      isObscurePassword = isObscure;
    });
  }

  // Widget template para INPUT, recebendo um controller e um valor booleano
  // para verificar se é um campo de senha, se for true o conteudo fica obscure
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(31, 35, 115, 1),
            ), // Define a cor da borda quando o campo está focado
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setObscure(!isObscurePassword);
                  },
                  icon: isObscurePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off_outlined),
                )
              : null),
      obscureText: widget.isPassword ? isObscurePassword : widget.isPassword,
    );
  }
}
