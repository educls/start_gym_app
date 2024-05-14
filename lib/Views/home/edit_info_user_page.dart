import 'dart:convert';
import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../controllers/users/users_controller.dart';
import '../../functions/sign_up/pick_img_perfil.dart';
import '../../models/users/ModelUserInfos.dart';
import '../../utils/provider/data_provider.dart';

class EditInfoUserPage extends StatefulWidget {
  const EditInfoUserPage({super.key});

  @override
  State<EditInfoUserPage> createState() => _EditInfoUserPageState();
}

class _EditInfoUserPageState extends State<EditInfoUserPage> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  String base64Image = '';
  XFile? _imageFile;
  late Image image = Image.asset('assets/img/profile_tab.png');

  late http.Response response;

  Map<String, dynamic> userInfos = {};
  late ModelUserInfos modelUserInfos;

  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();

  DataAppProvider? value;
  late Uint8List bytes = Uint8List(0);

  bool _isLoading = false;
  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  bool isCheck = false;
  bool showPassword = false;
  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void initProvider() {
    value = context.watch<DataAppProvider>();
  }

  void setUser(ModelUserInfos _modelUserInfos) {
    setState(() {
      txtName.text = _modelUserInfos.mensagem.name;
      txtNumero.text = _modelUserInfos.mensagem.numberwhats;
      txtEmail.text = _modelUserInfos.mensagem.email;
      txtPassword.text = _modelUserInfos.mensagem.password;
    });
  }

  void setImgFile(XFile? imgFile) {
    setState(() {
      _imageFile = imgFile;
    });
  }

  void setBase64Image(String base64Img) {
    setState(() {
      base64Image = base64Img;
      bytes = base64Decode(base64Image);
      image = Image.memory(bytes);
    });
  }

  void setPassword(String txtPass) {
    setState(() {
      txtPassword.text = txtPass;
    });
  }

  void getInfoUser() async {
    initProvider();
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));
    response = await getInformationsUser(value!.token);

    modelUserInfos = modelUserInfosFromMap(response.body);

    if (isBase64(modelUserInfos.photo)) {
      bytes = base64Decode(modelUserInfos.photo);
      image = Image.memory(bytes);
    }

    setUser(modelUserInfos);
    setLoading(false);
  }

  bool isBase64(String value) {
    try {
      base64Decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (txtEmail.text.isEmpty) {
      getInfoUser();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edição de Usuário'),
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
              : buildFormEditUser(bytes)
        ],
      ),
    );
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

  Widget buildFormEditUser(bytes) {
    var media = MediaQuery.of(context).size;
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
                        child: Stack(
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
                                    AssetImage('assets/img/camera_tab.png'),
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
                    controller: txtName,
                    hitText: "Nome",
                    icon: "assets/img/user_text.png",
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
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
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  RoundTextField(
                    controller: txtPassword,
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
                  SizedBox(
                    height: media.width * 0.3,
                  ),
                  RoundButton(
                    width: 330,
                    isLoading: _isLoading,
                    title: "Atualizar",
                    onPressed: () async {
                      setLoading(true);
                      await Future.delayed(const Duration(milliseconds: 200));
                      http.Response response = await editUser(
                          base64Image,
                          txtName.text,
                          txtNumero.text,
                          txtEmail.text,
                          txtPassword.text,
                          value!.token);

                      if (response.statusCode == 201) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Sucesso',
                          text: 'Usuario Atualizado',
                          disableBackBtn: true,
                          barrierDismissible: false,
                          confirmBtnText: 'Ok',
                          onConfirmBtnTap: () {
                            setLoading(false);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          text: 'Usuario não atualizado',
                          confirmBtnText: 'Ok',
                          title: 'Aviso',
                          confirmBtnColor: TColor.primaryColor1,
                          onConfirmBtnTap: () {
                            setLoading(false);
                            Navigator.pop(context);
                          },
                        );
                      }

                      setLoading(false);
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
