import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';
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
import 'package:start_gym_app/Views/questions/questions_page.dart';

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
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  bool isEditingName = false;
  bool isEditingPhone = false;
  void setEditingPhone(bool isEditing) {
    setState(() {
      isEditingPhone = isEditing;
    });
  }

  bool isEditingEmail = false;
  void setEditingEmail(bool isEditing) {
    setState(() {
      isEditingEmail = isEditing;
    });
  }

  bool isEditingPassoword = false;
  void setEditingPassword(bool isEditing) {
    setState(() {
      isEditingPassoword = isEditing;
    });
  }

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
      txtPhone.text = _modelUserInfos.mensagem.numberwhats;
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
      body: Stack(
        children: [
          _isLoading
              ? Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.black,
                    size: 50,
                  ),
                )
              : buildFormEditUser(bytes),
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
                  const SizedBox(height: 5),
                  TextField(
                    style: TextStyle(
                      color: TColor.lighBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    controller: txtName,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(isEditingName ? Icons.check : Icons.edit,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            isEditingName = !isEditingName;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    readOnly: !isEditingName,
                  ),
                  // Text(
                  //   'NOME ALUNO',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     color: TColor.lighBlue,
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showChoiceForPhotoPerfil();
                      },
                      child: Container(
                        width: 140,
                        height: 140,
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
                  const SizedBox(height: 20),
                  buildEditableField('Telefone', txtPhone, false,
                      isEditingPhone, setEditingPhone),
                  buildEditableField('Email', txtEmail, false, isEditingEmail,
                      setEditingEmail),
                  buildEditableField('Senha', txtPassword, true,
                      isEditingPassoword, setEditingPassword),
                  const SizedBox(height: 5),
                  buildOption('Avaliação física', TypeQuestionary.avalFisica),
                  buildOption('Histórico de atividades',
                      TypeQuestionary.histAtividades),
                  buildOption(
                      'Histórico de doenças', TypeQuestionary.histDoencas),
                  buildOption('Minha evolução', TypeQuestionary.minhaEvolucao),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.blue[900]),
                      label: Text(
                        'Voltar',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller,
      bool isPassword, bool isEditing, Function setEditingState) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: TColor.lighBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 226),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isEditing ? Colors.black : Colors.black38),
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(isEditing ? Icons.check : Icons.edit,
                          color: Colors.grey),
                      onPressed: () {
                        setEditingState(!isEditing);
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  obscureText: isPassword ? !isEditing : isPassword,
                  readOnly: !isEditing,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildOption(String text, TypeQuestionary enumType) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestionarioWidget(type: enumType),
            ),
          );
        },
        child: Text(
          text,
          style: TextStyle(
            color: TColor.lighBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// setLoading(true);
// await Future.delayed(const Duration(milliseconds: 200));
// http.Response response = await editUser(
//     base64Image,
//     txtName.text,
//     txtNumero.text,
//     txtEmail.text,
//     txtPassword.text,
//     value!.token);

// if (response.statusCode == 201) {
//   QuickAlert.show(
//     context: context,
//     type: QuickAlertType.success,
//     title: 'Sucesso',
//     text: 'Usuario Atualizado',
//     disableBackBtn: true,
//     barrierDismissible: false,
//     confirmBtnText: 'Ok',
//     onConfirmBtnTap: () {
//       setLoading(false);
//       Navigator.pop(context);
//       Navigator.pop(context);
//     },
//   );
// } else {
//   QuickAlert.show(
//     context: context,
//     type: QuickAlertType.warning,
//     text: 'Usuario não atualizado',
//     confirmBtnText: 'Ok',
//     title: 'Aviso',
//     confirmBtnColor: TColor.primaryColor1,
//     onConfirmBtnTap: () {
//       setLoading(false);
//       Navigator.pop(context);
//     },
//   );
// }

// setLoading(false);
