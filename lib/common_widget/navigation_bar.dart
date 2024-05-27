import 'package:flutter/material.dart';
import 'package:start_gym_app/common_widget/nav_bar_items.dart';

import '../utils/enums/user_roles.dart';

class NavBarCustom extends StatelessWidget {
  final NavBarType type;
  final List<Widget> itemsBar;
  final int currentIndex;
  final Function setCurrentIndexNavBar;

  const NavBarCustom({
    super.key,
    required this.type,
    required this.itemsBar,
    required this.currentIndex,
    required this.setCurrentIndexNavBar,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(204, 236, 236, 236),
      selectedFontSize: 20,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      currentIndex: currentIndex,
      onTap: (int newIndex) {
        setCurrentIndexNavBar(newIndex);
      },
      items: NavBarItemsCustom(type).getItems(),
    );
  }
}
