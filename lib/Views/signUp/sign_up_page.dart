import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_gym_app/functions/sign_up/sign_up_functions.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

import 'package:image_picker/image_picker.dart';

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
  String numberwhats = "";
  String email = "";
  String password = "";
  String confirmPassword = '';
  bool waitingConfirmationEmail = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    base64Image = prefs.getString('photoSignUp') ?? '';
    name = prefs.getString('nameSignUp') ?? '';
    numberwhats = prefs.getString('numberSignUp') ?? '';
    email = prefs.getString('emailSignUp') ?? '';
    password = prefs.getString('passwordSignUp') ?? '';
    confirmPassword = prefs.getString('passwordConfirmSignUp') ?? '';
    waitingConfirmationEmail = prefs.getBool('waitingConfirmation') ?? false;

    setState(() {
      base64Image = base64Image;
      txtName.text = name;
      txtNumero.text = numberwhats;
      txtEmail.text = email;
      txtPassword.text = password;
      txtConfirmPassword.text = confirmPassword;
    });
    print(txtEmail.text);

    if (waitingConfirmationEmail == true) {
      setLoading(true);
      SignUpFunctions(
        context: context,
        base64Image: base64Image,
        txtName: txtName,
        txtNumero: txtNumero,
        txtEmail: txtEmail,
        txtPassword: txtPassword,
        txtConfirmPassword: txtConfirmPassword,
        setLoading: setLoading,
        waitingConfirmationEmail: waitingConfirmationEmail,
      ).onPressedForSignUpButton(context);
    }
  }

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

  void setPassword(String txtPass) {
    setState(() {
      txtPassword.text = txtPass;
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
                                  ),
                                ),
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
                  setPassword: setPassword,
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
                  setPassword: setPassword,
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
                  setPassword: setPassword,
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
                  setPassword: setPassword,
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
                txtPassword.text.isNotEmpty
                    ? FlutterPwValidator(
                        controller: txtPassword,
                        minLength: 6,
                        uppercaseCharCount: 1,
                        lowercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        width: 350,
                        height: 130,
                        onSuccess: () {},
                        onFail: () {},
                      )
                    : Container(),
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
                  setPassword: setPassword,
                  hitText: "Confirme sua senha",
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
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundButton(
                  width: 330,
                  isLoading: isLoading,
                  title: "Cadastrar",
                  onPressed: () async {
                    setLoading(true);
                    await Future.delayed(const Duration(milliseconds: 500));
                    SignUpFunctions(
                      context: context,
                      base64Image: base64Image,
                      txtName: txtName,
                      txtNumero: txtNumero,
                      txtEmail: txtEmail,
                      txtPassword: txtPassword,
                      txtConfirmPassword: txtConfirmPassword,
                      setLoading: setLoading,
                      waitingConfirmationEmail: false,
                    ).onPressedForSignUpButton(context);
                  },
                ),
                SizedBox(
                  height: media.width * 0.2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
