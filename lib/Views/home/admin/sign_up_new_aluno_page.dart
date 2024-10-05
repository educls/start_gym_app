import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../common/color_extension.dart';
import '../../../common_widget/round_button.dart';
import '../../../common_widget/round_textfield.dart';
import '../../../controllers/users/users_controller.dart';
import '../../../utils/provider/data_provider.dart';

class SignUpNewAluno extends StatefulWidget {
  const SignUpNewAluno({super.key});

  @override
  State<SignUpNewAluno> createState() => _SignUpNewAlunoState();
}

class _SignUpNewAlunoState extends State<SignUpNewAluno> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();

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
        title: const Text("Cadastrar novo Aluno"),
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
                              //     txtPassword.text.isEmpty) {
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
                              //   http.Response response = await signUpNewAluno(
                              //       txtName.text,
                              //       txtEmail.text,
                              //       txtPassword.text,
                              //       value!.token);
                              //   if (response.statusCode == 401) {
                              //     QuickAlert.show(
                              //       context: context,
                              //       type: QuickAlertType.warning,
                              //       text: 'Aluno não cadastrado',
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
                              //       text:
                              //           'Para efetuar o cadastro o aluno necessita verificar o email',
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
