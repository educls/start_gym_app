import 'package:flutter/material.dart';

class CustomTopLogin extends StatelessWidget {
  final String title;
  final String pathLogo;
  const CustomTopLogin({super.key, required this.title, required this.pathLogo});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      width: media.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage("assets/images/logoStartGymAmarelo.png"),
            color: Color.fromRGBO(242, 187, 19, 5),
            size: 90,
          ),
          Text(
            "Start Gym",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 2,
            ),
          )
        ],
      ),
    );
  }
}
