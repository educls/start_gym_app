

import 'package:flutter/material.dart';

mixin QuestionTextFieldStateHelper<T extends StatefulWidget> on State<T> {
  
  DateTime selectedDate = DateTime.now();
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        print(selectedDate);
        selectedDate = picked;
      });
    }
  }
}