import 'package:flutter/material.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Image.asset(
          PathConstants.arrowLeft,
          color: ColorConstants.white,
          width: 24, // Defina a largura desejada
          height: 24, // Defina a altura desejada
        ),
      ),
    );
  }
}
