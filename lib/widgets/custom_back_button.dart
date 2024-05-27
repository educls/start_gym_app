import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () {Navigator.of(context).pop();},
        icon: Icon(Icons.arrow_back, color: Colors.blue[900]),
        label: Text(
          'Voltar',
          style: TextStyle(color: Colors.blue[900]),
        ),
      ),
    );
  }
}