import 'package:flutter/material.dart';

class CustomGrayText extends StatelessWidget {
  final String text;
  const CustomGrayText({
    super.key,
    required this.text,
  });

  // Widget template de um Text, recebe um valor string e retorna um widget
  // TEXT com a cor cinza claro
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.left,
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
