import 'package:flutter/material.dart';
import 'package:start_gym_app/utils/constants/path_contants.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text("Corpinho"),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 1, items: const [
        BottomNavigationBarItem(
            icon: Image(image: AssetImage(PathConstants.workouts)),
            label: "Treinos"),
        BottomNavigationBarItem(
            icon: Image(image: AssetImage(PathConstants.home)), label: "Home"),
        BottomNavigationBarItem(
            icon: Image(image: AssetImage(PathConstants.settings)),
            label: "Configurações")
      ]),
    );
  }
}
