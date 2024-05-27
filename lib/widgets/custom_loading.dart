import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  final Color color;
  const CustomLoading({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.dotsTriangle(
      color: color,
      size: 30,
    );
  }
}
