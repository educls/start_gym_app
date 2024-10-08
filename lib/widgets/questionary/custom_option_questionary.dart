import 'package:flutter/material.dart';
import 'package:start_gym_app/views/questions/questionaries_page.dart';

import '../../utils/constants/color_constants.dart';
import '../../utils/enums/questionary_roles.dart';

class OptionQuestionary extends StatelessWidget {
  final String text;
  final TypeQuestionary type;
  final String pathIconImage;
  const OptionQuestionary({
    super.key,
    required this.text,
    required this.type,
    required this.pathIconImage,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuestionariesWidget(type: type),
          ));
        },
        child: Container(
          height: media.height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                pathIconImage,
                width: 60,
                height: 60,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: ColorConstants.darkBlue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
