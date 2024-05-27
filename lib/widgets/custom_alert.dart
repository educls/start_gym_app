import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  final String title;
  final Function action1;
  final Function action2;
  final Widget action1Title;
  final Widget action2Title;
  const CustomAlert({
    super.key,
    required this.title,
    required this.action1,
    required this.action2,
    required this.action1Title,
    required this.action2Title,
  });

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              widget.action1();
            },
            child: widget.action1Title,
          ),
          TextButton(
            onPressed: () {
              widget.action2();
            },
            child: widget.action2Title,
          )
        ],
      ),
    );
  }
}
