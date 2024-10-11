import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:start_gym_app/controllers/users/users_controller.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/round_button.dart';
import '../../../common_widget/round_textfield.dart';
import '../../../utils/provider/data_provider.dart';

class SignUpNewTeacher extends StatefulWidget {
  const SignUpNewTeacher({super.key});

  @override
  State<SignUpNewTeacher> createState() => _SignUpNewTeacherState();
}

class _SignUpNewTeacherState extends State<SignUpNewTeacher> {
  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();

  final ValueNotifier<String> _dropValue = ValueNotifier<String>('');

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  List<String> dropdownOptionsTeacherType = <String>[
    "Personal",
    "Fisioterapeuta"
  ];
  String dropdownValue = '';
  // DataAppProvider? value;

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

  bool isCheck = false;
  bool showPassword = false;
  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  // void initProvider() {
  //   value = context.watch<DataAppProvider>();
  // }

  @override
  Widget build(BuildContext context) {
    // if (value == null) {
    //   initProvider();
    // }
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar novo Profissional"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          const ImageIcon(
                            AssetImage("assets/images/logoStartGymAmarelo.png"),
                            color: Color.fromRGBO(242, 187, 19, 5),
                            size: 160,
                          ),
                          SizedBox(
                            height: media.width * 0.1,
                          ),
                          RoundTextField(
                            controller: txtName,
                            hitText: "Nome",
                            icon: "assets/img/user_text.png",
                            keyboardType: TextInputType.name,
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
                            height: media.width * 0.04,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ValueListenableBuilder<String>(
                                valueListenable: _dropValue,
                                builder:
                                    (BuildContext context, String value, _) {
                                  return DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text("Selecione uma Opção"),
                                    value: (value.isEmpty) ? null : value,
                                    onChanged: (choice) => {
                                      _dropValue.value = choice.toString(),
                                      print(_dropValue.value)
                                    },
                                    onTap: () {},
                                    items: dropdownOptionsTeacherType
                                        .map((String op) {
                                      return DropdownMenuItem<String>(
                                        value: op,
                                        child: Text(op),
                                      );
                                    }).toList(),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: media.width * 0.2,
                          ),
                          RoundButton(
                            width: 330,
                            isLoading: _isLoading,
                            title: "Cadastrar",
                            onPressed: () async {
                              // setLoading(true);
                              // await Future.delayed(
                              //     const Duration(milliseconds: 200));
                              // if (txtName.text.isEmpty ||
                              //     txtEmail.text.isEmpty ||
                              //     txtPassword.text.isEmpty ||
                              //     _dropValue.value.isEmpty) {
                              //   QuickAlert.show(
                              //     context: context,
                              //     type: QuickAlertType.warning,
                              //     text: 'Alguns Campos estão vazios',
                              //     confirmBtnText: 'Ok',
                              //     title: 'Aviso',
                              //     confirmBtnColor: TColor.primaryColor1,
                              //     onConfirmBtnTap: () {
                              //       setLoading(false);
                              //       Navigator.pop(context);
                              //     },
                              //   );
                              // } else {
                              //   http.Response response = await signUpNewTeacher(
                              //       txtName.text,
                              //       txtEmail.text,
                              //       txtPassword.text,
                              //       _dropValue.value,
                              //       value!.token);
                              //   if (response.statusCode == 401) {
                              //     QuickAlert.show(
                              //       context: context,
                              //       type: QuickAlertType.warning,
                              //       text: 'Professor não cadastrado',
                              //       confirmBtnText: 'Ok',
                              //       title: 'Aviso',
                              //       confirmBtnColor: TColor.primaryColor1,
                              //       onConfirmBtnTap: () {
                              //         setLoading(false);
                              //         Navigator.pop(context);
                              //       },
                              //     );
                              //   } else {
                              //     QuickAlert.show(
                              //       context: context,
                              //       type: QuickAlertType.success,
                              //       title: 'Sucesso',
                              //       text: 'Cadastro Realizado!',
                              //       disableBackBtn: true,
                              //       barrierDismissible: false,
                              //       confirmBtnText: 'Ok',
                              //       onConfirmBtnTap: () {
                              //         setLoading(false);
                              //         Navigator.pop(context);
                              //         Navigator.pop(context);
                              //       },
                              //     );
                              //   }
                              //   setLoading(false);
                              // }
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
            ),
    );
  }
}
