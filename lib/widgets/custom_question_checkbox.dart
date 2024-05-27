import 'package:flutter/material.dart';

import '../utils/constants/questions_constants.dart';

class CustomCheckBoxList extends StatelessWidget {
  final dynamic currentQuestionValue;
  final Function setSelectedChoicesQuestions;
  const CustomCheckBoxList({
    super.key,
    required this.currentQuestionValue,
    required this.setSelectedChoicesQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (currentQuestionValue as List<Choice>).asMap().entries.map<Widget>((entry) {
        int index = entry.key;
        Choice choice = entry.value;
        return CheckboxListTile(
          title: Text(choice.title),
          value: choice.isSelected,
          onChanged: (bool? value) {
            setSelectedChoicesQuestions(choice.title, value ?? false, index);
          },
        );
      }).toList(),
    );
  }
}
