import 'package:flutter/material.dart';

import '../../utils/constants/color_constants.dart';
import '../../../utils/constants/path_contants.dart';
import '../../../widgets/custom_back_button.dart';

class CustomAppBarEditUser extends StatelessWidget {
  final String title;
  final String? pathLogo;
  const CustomAppBarEditUser({
    super.key,
    required this.title,
    this.pathLogo,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        color: ColorConstants.darkBlue,
      ),
      width: media.width * 1,
      height: media.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Alinhamento à esquerda
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centralizar verticalmente
        children: [
          CustomBackButton(),
          // Botão de voltar
          const SizedBox(width: 50), // Espaçamento entre o botão e a imagem
          Image.asset(
            PathConstants.logoStartGym, // Caminho da sua imagem
            height: 70, // Tamanho da imagem
          ),
          const SizedBox(width: 10), // Espaçamento entre a imagem e o texto
          Text(
            "Start Gym",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ), // Estilo do texto
          ),
        ],
      ),
    );
  }
}
