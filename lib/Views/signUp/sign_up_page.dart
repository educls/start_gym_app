import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String name = "";
  String lastName = "";
  String email = "";
  String password = "";
  bool isLoading = false;
  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  bool isCheck = false;
  bool showPassword = false;
  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedImage;
      });

      final bytes = await File(_imageFile!.path).readAsBytes();
      String base64Image = base64Encode(bytes);

      print('Imagem em base64: $base64Image');
    } catch (e) {
      print('Erro ao pegar a imagem: $e');
    }
  }

  Uint8List decodeImage(String base64Image) {
    List<int> bytes = base64.decode(base64Image);
    return Uint8List.fromList(bytes);
  }

  void showChoiceForPhotoPerfil() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Escolha uma opção',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.photo_library,
                      size: 60,
                      color: Colors.grey[600],
                    )),
                TextButton(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 60,
                      color: Colors.grey[600],
                    )),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Crie sua Conta",
          style: TextStyle(
              color: TColor.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkeysignup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showChoiceForPhotoPerfil();
                      },
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: _imageFile == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 60,
                                color: Colors.grey[600],
                              )
                            : Stack(
                                children: [
                                  Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.file(
                                          File(_imageFile!.path),
                                          fit: BoxFit.cover,
                                          width: 160,
                                          height: 160,
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0.0, 1),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  RoundTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor insira seu Nome.";
                      }
                      return null;
                    },
                    controller: txtName,
                    hitText: "Nome",
                    icon: "assets/img/user_text.png",
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor insira seu Numero.";
                      }
                      return null;
                    },
                    controller: txtNumero,
                    hitText: "Numero(whatsapp)",
                    icon: "assets/img/user_text.png",
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtEmail,
                    hitText: "Email",
                    icon: "assets/img/email.png",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor insira seu Email.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Porfavor insira sua Senha.";
                      }
                      return null;
                    },
                    hitText: "Senha",
                    icon: "assets/img/lock.png",
                    obscureText: !showPassword,
                    rigtIcon: TextButton(
                      onPressed: () {
                        togglePasswordVisibility();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          child: !showPassword
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: TColor.primaryColor1,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: TColor.primaryColor1,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtConfirmPassword,
                    validator: (value) {
                      if (value != txtPassword.text) {
                        return "As senha não conferem.";
                      }
                      return null;
                    },
                    hitText: "Confirme sua senha",
                    icon: "assets/img/lock.png",
                    obscureText: !showPassword,
                    rigtIcon: TextButton(
                      onPressed: () {
                        togglePasswordVisibility();
                      },
                      child: Container(
                          alignment: Alignment.center, width: 20, height: 20),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.3,
                  ),
                  RoundButton(
                    width: 330,
                    isLoading: isLoading,
                    title: "Cadastrar",
                    onPressed: () async {
                      Navigator.pushNamed(context, '/test');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
