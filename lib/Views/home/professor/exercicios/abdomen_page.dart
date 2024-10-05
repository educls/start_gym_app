import 'package:flutter/material.dart';

class AbdomenPage extends StatefulWidget {
  const AbdomenPage({super.key});

  @override
  State<AbdomenPage> createState() => _AbdomenPageState();
}

class _AbdomenPageState extends State<AbdomenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Cor de fundo azul
      body: Center(
        child: Text(
          'AbdomenPage', // Texto centralizado
          style: TextStyle(
            fontSize: 24, // Tamanho da fonte
            color: Colors.white, // Cor do texto
          ),
        ),
      ),
    );
  }
}
