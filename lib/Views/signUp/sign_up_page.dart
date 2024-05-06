import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_gym_app/functions/sign_up/pick_img_perfil.dart';
import 'package:start_gym_app/functions/sign_up/sign_up_functions.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String base64Image = '';
  XFile? _imageFile;

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
  late Uint8List bytes = base64Decode(base64Image);

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

  void setBase64Image(String base64Img) {
    setState(() {
      base64Image = base64Img;
      bytes = base64Decode(base64Image);
    });
    print(base64Image);
  }

  void setImgFile(XFile? imgFile) {
    setState(() {
      _imageFile = imgFile;
    });
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
                      PickImgFunction(
                        context: context,
                        setImgFile: setImgFile,
                        setBase64Image: setBase64Image,
                      ).pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                      Clipboard.setData(ClipboardData(text: base64Image));
                    },
                    child: Icon(
                      Icons.photo_library,
                      size: 60,
                      color: Colors.grey[600],
                    )),
                TextButton(
                  onPressed: () {
                    PickImgFunction(
                      context: context,
                      setImgFile: setImgFile,
                      setBase64Image: setBase64Image,
                    ).pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                    Clipboard.setData(ClipboardData(text: base64Image));
                  },
                  child: Icon(
                    Icons.camera_alt,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Uint8List decodeImage(String base64Image) {
    List<int> bytes = base64.decode(base64Image);
    return Uint8List.fromList(bytes);
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
              ? Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.black,
                    size: 50,
                  ),
                )
              : buildFormSignUp()
        ],
      ),
    );
  }

  Widget buildFormSignUp() {
    var media = MediaQuery.of(context).size;
    Image image = Image.memory(bytes);
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkeysignup,
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 350),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 80.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
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
                                      child: CircleAvatar(
                                        backgroundImage: image.image,
                                        minRadius: 0,
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
                                        child: ImageIcon(
                                          AssetImage(
                                              'assets/img/camera_tab.png'),
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
                    formatter: TelefoneInputFormatter(),
                    controller: txtNumero,
                    hitText: "(00) 12345-1234",
                    icon: "assets/img/zap_icone.png",
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
                      await Future.delayed(const Duration(milliseconds: 2000));
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
      ),
    );
  }
}
