import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_gym_app/models/users/LoginModel.dart';
import 'package:http/http.dart' as http;

import '../../controllers/users/users_controller.dart';
import '../../utils/provider/data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          timer.cancel();
          setState(() {
            emailSend = false;
            _remainingTimeInSeconds = 60;
          });
        }
      });
    });
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';
    String savedPassword = prefs.getString('password') ?? '';
    bool savedUserRemember = prefs.getBool('rememberUser') ?? false;

    setState(() {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberUser = savedUserRemember;
    });
  }

  Future<void> _saveCredentialsAndPreferences() async {
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
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
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
                      ? const Center(child: CircularProgressIndicator())
                      : const Center()
                ],
              )),
          Positioned(
              bottom: 00,
              child: _isLoading ? const Center() : _buildBottom(context)),
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
            AssetImage("assets/images/icon_logo.png"),
            color: Colors.yellow,
            size: 80,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  toggleForm();
                },
                icon: const Icon(Icons.arrow_back)),
            const Text(
              "Recuperar Senha",
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 60),
        _buildGreyText("Email"),
        _buildInputField(emailController, false),
        const SizedBox(height: 40),
        _buildGreyText(emailSend == true
            ? 'Enviar Novamente em: $_remainingTimeInSeconds segundos'
            : ''),
        const SizedBox(height: 10),
        _buildResetButton(),
        const SizedBox(height: 150)
      ],
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
              color: Colors.amber, fontSize: 32, fontWeight: FontWeight.w500),
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
        _buildLoginButton(),
        const SizedBox(height: 10),
        _buildSignUpButton(),
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
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setObscure(!isObscurePassword);
                  },
                  icon: isObscurePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off_outlined))
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
                }),
            _buildGreyText("Lembrar-me"),
          ],
        ),
        TextButton(
            onPressed: () {
              toggleForm();
            },
            child: _buildGreyText("Esqueci Minha Senha"))
      ],
    );
  }

// Retorna um Widget ElevatedButton com a logica para o LOGIN
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _remainingTimeInSecondsBlock == 60 ||
              _remainingTimeInSecondsBlock == 0
          ? () async {
              setLoading(true);
              //Funcao que executa toda a logica de LOGIN
              onPressedForLoginButton();
            }
          : null,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: const Color.fromARGB(255, 253, 224, 136),
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN",
          style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

// Executa toda a logica do LOGIN
  void onPressedForLoginButton() async {
    final value = Provider.of<DataAppProvider>(context, listen: false);

    // Envia a requisicao de LOGIN para a API e armazena a resposta a ser
    // tratata pelo app
    late http.Response response;
    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      response = await userLogin(emailController.text, passwordController.text);
    }

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text("Campos Vazios"),
            );
          });
    } else if (response.statusCode == 401) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      var body = json.decode(response.body);
      setState(() {
        attempts = body['tentativas'];
      });
      if (attempts == 5) {
        startTimer();
      }
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          var body = json.decode(response.body);
          return AlertDialog(
            content: Text('${body['mensagem']}'),
          );
        },
      );
    } else {
      if (rememberUser) {
        _saveCredentialsAndPreferences();
      }
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        attempts = 0;
      });
      var body = json.decode(response.body);
      value.setToken(body["token"]);
      setLoading(false);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    }
  }

  Widget _buildSignUpButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {},
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 20,
            backgroundColor: Colors.amber,
            shadowColor: const Color.fromARGB(255, 253, 224, 136),
            minimumSize: const Size(160, 60)),
        child: const Text("PRIMEIRO ACESSO",
            style: TextStyle(fontSize: 14, color: Colors.black)),
      ),
    );
  }

// Retorna um Widget ElevatedButton com a logica para o envio do email para
// a Redefinição da Senha
  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: emailSend == false
          ? () async {
              setLoading(true);
              onPressedForSendEmailResetPassword();
            }
          : null,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: const Color.fromARGB(255, 253, 224, 136),
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("ENVIAR",
          style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

// Executa toda a logica do botao que envia o email para a redefinicao da senha
  void onPressedForSendEmailResetPassword() async {
    // Envia a requisicao do Envio de email para a API e armazena a resposta
    //a ser tratata pelo app
    http.Response response =
        await userSendEmailForResetPassword(emailController.text);

    if (response.statusCode == 200) {
      startTimerForResetPassword();
      setState(() {
        emailSend = true;
      });
    }

    if (emailController.text.isEmpty || response.statusCode == 401) {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text("Email Invalido"),
            );
          });
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      setLoading(false);
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Email Enviado para ${emailController.text}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 22, 134, 26),
                  )),
            );
          });
    }
  }

// Retorna um Widget com o LOGIN COM O GOOGLE(OBS: ainda nao implementado)
  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Login usando"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/google.png")),
            ],
          )
        ],
      ),
    );
  }
}
