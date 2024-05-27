import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageHelper {
  final BuildContext context;
  final Function setImgFile;
  final Function setBase64Image;

  const ImageHelper({
    required this.context,
    required this.setImgFile,
    required this.setBase64Image,
  });

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedImage = await picker.pickImage(
          source: source, maxHeight: 1000, maxWidth: 1000);
      setImgFile(pickedImage);

      final bytes = await File(pickedImage!.path).readAsBytes();
      String base64Image = base64Encode(bytes);
      setBase64Image(base64Image);

      // print('Imagem em base64: $base64Image');
    } catch (e) {
      print('Erro ao pegar a imagem: $e');
    }
  }
}
