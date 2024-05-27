import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldConfig {
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String hintText;
  final TextAlign textAlign;
  final TextStyle textStyle;

  TextFieldConfig({
    required this.readOnly,
    required this.onTap,
    required this.inputFormatters,
    required this.keyboardType,
    required this.maxLines,
    required this.hintText,
    required this.textAlign,
    required this.textStyle,
  });
}
