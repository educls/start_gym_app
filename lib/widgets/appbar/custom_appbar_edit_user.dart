import 'package:flutter/material.dart';

import '../../utils/constants/color_constants.dart';

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
        color: ColorConstants.blue,
      ),
      width: media.width * 1,
      height: media.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if(pathLogo == '')
              ImageIcon(
                AssetImage(pathLogo!),
                color: const Color.fromRGBO(242, 187, 19, 5),
                size: 60,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
