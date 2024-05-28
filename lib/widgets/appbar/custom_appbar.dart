import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/color_constants.dart';
import '../../utils/enums/user_roles.dart';
import '../../utils/provider/data_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final NavBarType type;
  final Image userImage;
  final String editRoute;

  const CustomAppBar({
    super.key,
    required this.userName,
    required this.type,
    required this.userImage,
    required this.editRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstants.blue,
      ),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Olá,",
                          style: TextStyle(color: Color.fromARGB(255, 204, 174, 4), fontSize: 22),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        userName,
                        style: const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                  const Text(
                    'Acompanhe sua conquistas',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, editRoute);
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: userImage.image,
                        radius: 35,
                      ),
                      Text(
                        '  ${Provider.of<DataAppProvider>(context, listen: true).userInfos.mensagem.accounttype}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200.0);
}
