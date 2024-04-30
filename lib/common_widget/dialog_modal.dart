import 'package:flutter/material.dart';

class DialogModal extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;
  final bool isLoading;

  const DialogModal({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
