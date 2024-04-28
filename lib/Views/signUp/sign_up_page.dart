import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/widgets/quickalert_container.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

import '../../controllers/users/users_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String base64Image = '';

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

  bool _isLoading = false;
  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      setState(() {
        _imageFile = pickedImage;
      });

      final bytes = await File(_imageFile!.path).readAsBytes();
      base64Image = base64Encode(bytes);

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Crie sua Conta",
            style: TextStyle(
                color: TColor.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: Stack(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : buildFormSignUp()
          ],
        ));
  }

  Widget buildFormSignUp() {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                      setLoading(true);
                      await Future.delayed(const Duration(milliseconds: 500));
                      await signUpNewUser();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpNewUser() async {
    String photoPerfilBase64Encode = base64Image;
    String name = txtName.text;
    String numWhats = txtNumero.text;
    String email = txtEmail.text;
    String password = txtPassword.text;
    String confirmPassword = txtConfirmPassword.text;

    if (name.isEmpty ||
        numWhats.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Alguns Campos estão vazios',
        confirmBtnText: 'Ok',
        title: 'Aviso',
        confirmBtnColor: TColor.primaryColor1,
        onConfirmBtnTap: () {
          setLoading(false);
          Navigator.pop(context);
        },
      );
    } else if (password != confirmPassword) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'As senhas não conferem',
        confirmBtnText: 'Ok',
        title: 'Aviso',
        confirmBtnColor: TColor.primaryColor1,
        onConfirmBtnTap: () {
          setLoading(false);
          Navigator.pop(context);
        },
      );
    } else {
      sendEmailForVerifiedEmail(txtEmail.text);
      await Future.delayed(const Duration(milliseconds: 500));
      await waitForEmailVerified();
      await Future.delayed(const Duration(milliseconds: 100));
      setLoading(true);
      await Future.delayed(const Duration(milliseconds: 700));
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Cadastro Realizado com Sucesso!',
        disableBackBtn: true,
        barrierDismissible: false,
        onConfirmBtnTap: () {
          setLoading(false);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    }
  }

  Future<void> waitForEmailVerified() async {
    bool receivedData = false;
    late http.Response response;
    late dynamic body;

    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Aguardando',
      text: 'Confirmação de Email',
      confirmBtnText: 'Ok',
      barrierDismissible: false,
      disableBackBtn: true,
    );

    // Loop infinito até que os dados sejam recebidos
    while (!receivedData) {
      await Future.delayed(const Duration(milliseconds: 5000));
      // Simula uma operação assíncrona que verifica se os dados foram recebidos
      response = await checkIfEmailIsVerified(txtEmail.text);
      body = json.decode(response.body);
      print(body);

      // Verifica se os dados foram recebidos (você pode substituir isso por sua lógica real)
      if (body['mensagem'] == true) {
        setState(() {
          receivedData = true;
        });
        Navigator.pop(context);
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Email foi confirmado com sucesso!',
          disableBackBtn: true,
          barrierDismissible: false,
          onConfirmBtnTap: () {
            setLoading(false);
            Navigator.pop(context);
          },
        );
      }
    }
  }
}
