import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common_widget/round_button.dart';
import '../../functions/login/login_functions.dart';
import '../../functions/reset_pass/reset_password_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool isObscurePassword = true;
  bool showLoginForm = true;
  bool _isLoading = false;
  var attempts = 0;
  late int _remainingTimeInSeconds = 60;
  late int _remainingTimeInSecondsBlock = 60;
  bool emailSend = false;
  bool waitingConfirmation = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void setObscure(bool isObscure) {
    setState(() {
      isObscurePassword = isObscure;
    });
  }

// Toggle para mudança das telas de LOGIN e tela ESQUECI MINHA SENHA
  void toggleForm() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void setAttempts(int attempt) {
    setState(() {
      attempts = attempt;
    });
  }

  void setEmailSend(bool sent) {
    setState(() {
      emailSend = sent;
    });
  }

// Contagem regressiva para o desbloqueio da conta no login
  void startTimer() {
    _remainingTimeInSecondsBlock = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTimeInSecondsBlock > 0) {
          _remainingTimeInSecondsBlock--;
        } else {
          timer.cancel();
          attempts = 0;
        }
      });
    });
  }

// Contagem regressiva para o reenvio do email de reset de senha
  void startTimerForResetPassword() {
    _remainingTimeInSeconds = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(
        () {
          if (_remainingTimeInSeconds > 0) {
            _remainingTimeInSeconds--;
          } else {
            timer.cancel();
            setState(() {
              emailSend = false;
              _remainingTimeInSeconds = 60;
            });
          }
        },
      );
    });
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';
    String savedPassword = prefs.getString('password') ?? '';
    bool savedUserRemember = prefs.getBool('rememberUser') ?? false;
    bool waitingConfirmationEmail =
        prefs.getBool('waitingConfirmation') ?? false;
    String emailSignUo = prefs.getString('emailSignUp') ?? '';
    print(emailSignUo);

    if (waitingConfirmationEmail == true) {
      Navigator.pushNamed(context, '/cadastro');
    }

    setState(() {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberUser = savedUserRemember;
    });
  }

  Future<void> saveCredentialsAndPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
    prefs.setString('password', passwordController.text);
    prefs.setBool('rememberUser', rememberUser);
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(31, 133, 133, 133),
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.1), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(
            top: 50,
            child: Column(
              children: [
                _buildTop(),
                const SizedBox(height: 200),
                _isLoading
                    ? Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : const Center()
              ],
            ),
          ),
          Positioned(
            bottom: 00,
            child: _isLoading ? const Center() : _buildBottom(context),
          ),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage("assets/images/logoStartGymAmarelo.png"),
            color: Color.fromRGBO(242, 187, 19, 5),
            size: 90,
          ),
          Text(
            "Start Gym",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom(context) {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Container(
          constraints: const BoxConstraints(minHeight: 50),
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: showLoginForm
                  ? _buildLoginForm(context)
                  : _buildResetPasswordForm()),
        ),
      ),
    );
  }

// Conteudo da tela ESQUECI MINHA SENHA
  Widget _buildResetPasswordForm() {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    toggleForm();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  "Recuperar Senha",
                  style: TextStyle(
                      color: Color.fromRGBO(31, 35, 115, 1),
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Row(
              children: [
                _buildGreyText("Email"),
              ],
            ),
            _buildInputField(emailController, false),
            const SizedBox(height: 40),
            _buildGreyText(emailSend == true
                ? 'Enviar Novamente em: $_remainingTimeInSeconds segundos'
                : ''),
            const SizedBox(height: 10),
            _buildResetButton(),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }

// Conteudo da tela de LOGIN
  Widget _buildLoginForm(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bem Vindo",
          style: TextStyle(
              color: Color.fromRGBO(31, 35, 115, 1),
              fontSize: 32,
              fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Realizar Login"),
        const SizedBox(height: 20),
        _buildGreyText("Email"),
        _buildInputField(emailController, false),
        const SizedBox(height: 20),
        _buildGreyText("Senha"),
        _buildInputField(passwordController, true),
        SizedBox(height: attempts < 5 ? 0 : 20),
        _buildShowBlockAccountOrNot(),
        _buildGreyText(attempts == 5
            ? 'Desbloqueio em: $_remainingTimeInSecondsBlock segundos'
            : ''),
        SizedBox(height: attempts < 5 ? 0 : 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildRoundLoginButton(),
        const SizedBox(height: 10),
        _buildRoundSignUpButton(),
      ],
    );
  }

// Retorna um Widget Row que mostra se a conta esta BLOQUEADA ou NAO
  Widget _buildShowBlockAccountOrNot() {
    return Row(
      children: [
        Text(
          attempts >= 3 && attempts < 5
              ? '${5 - attempts} tentativas restantes'
              : attempts == 5
                  ? 'Usuário Bloqueado'
                  : '',
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

// Widget template de um Text, recebe um valor string e retorna um widget
// TEXT com a cor cinza claro
  Widget _buildGreyText(String text) {
    return Text(
      textAlign: TextAlign.left,
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

// Widget template para INPUT, recebendo um controller e um valor booleano
// para verificar se é um campo de senha, se for true o conteudo fica obscure
  Widget _buildInputField(TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(31, 35, 115, 1),
            ), // Define a cor da borda quando o campo está focado
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setObscure(!isObscurePassword);
                  },
                  icon: isObscurePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off_outlined),
                )
              : null),
      obscureText: isPassword ? isObscurePassword : isPassword,
    );
  }

// Retorna um Widget com uma linha contendo os botões de lembrar login sendo um checkbox
// e um TEXTBUTTON para a tela ESQUECI MINHA SENHA
  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberUser,
              onChanged: (value) {
                setState(() {
                  rememberUser = value!;
                });
              },
              activeColor: const Color.fromRGBO(
                  50, 56, 230, 1), // Definindo a cor azul para o Checkbox
            ),
            _buildGreyText("Lembrar-me"),
          ],
        ),
        TextButton(
          onPressed: () {
            toggleForm();
          },
          child: _buildGreyText("Esqueci Minha Senha"),
        )
      ],
    );
  }

  Widget _buildRoundLoginButton() {
    return RoundButton(
        width: 330,
        isLoading: _isLoading,
        title: "LOGIN",
        onPressed: _remainingTimeInSecondsBlock == 60 ||
                _remainingTimeInSecondsBlock == 0
            ? () async {
                setLoading(true);
                await Future.delayed(const Duration(milliseconds: 500));
                //Classe que executa toda a logica de LOGIN
                await LoginFunctions(
                        context: context,
                        emailController: emailController,
                        passwordController: passwordController,
                        rememberUser: rememberUser,
                        setLoading: setLoading,
                        attempts: attempts,
                        startTimer: startTimer,
                        setAttempts: setAttempts,
                        saveCredentialsAndPreferences:
                            saveCredentialsAndPreferences)
                    .onPressedForLoginButton(context);
              }
            : () {
                null;
              });
  }

// Retorna um Widget Button que abre a tela de PRIMEIRO ACESSO(Cadastro)
  Widget _buildRoundSignUpButton() {
    // return RoundButton(
    //   width: 200,
    //   isLoading: _isLoading,
    //   title: "PRIMEIRO ACESSO",
    //   type: RoundButtonType.bgSGradient,
    //   onPressed: () async {
    //     Navigator.pushNamed(context, '/cadastro');
    //   },
    // );
    return Center(
        child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(50),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastro');
        },
        child: _buildGreyText("Primeiro Acesso"),
      ),
    ));
  }

// Retorna um Widget Button com a logica para o envio do email para
// a Redefinição da Senha
  Widget _buildResetButton() {
    return RoundButton(
      width: 330,
      title: 'ENVIAR',
      onPressed: emailSend == false
          ? () async {
              setLoading(true);
              ResetPasswordFunctions(
                      context: context,
                      emailController: emailController,
                      startTimerForResetPassword: startTimerForResetPassword,
                      setEmailSend: setEmailSend,
                      setLoading: setLoading)
                  .onPressedForSendEmailResetPasswordButton(context);
            }
          : () {
              null;
            },
    );
  }
}
