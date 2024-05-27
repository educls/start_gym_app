import 'package:flutter/material.dart';

import '../../utils/enums/user_roles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final NavBarType type;
  final Image userImage;
  final String editRoute;

  CustomAppBar({
    super.key,
    required this.userName,
    required this.type,
    required this.userImage,
    required this.editRoute,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        "Olá $userName",
        textAlign: TextAlign.end,
      ),
      titleSpacing: 0,
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, editRoute);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 1),
            child: CircleAvatar(
              backgroundImage: userImage.image,
              radius: 35,
            ),
          ),
        )
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
