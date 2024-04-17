import 'package:flutter/material.dart';

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

  void setObscure(bool isObscure) {
    setState(() {
      isObscurePassword = isObscure;
    });
  }

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
              top: 80,
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
              bottom: 0, child: _isLoading ? const Center() : _buildBottom()),
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

  // Widget _buildAnimatedContent() {
  //   return AnimatedSwitcher(
  //     duration: const Duration(milliseconds: 1000),
  //     switchInCurve: Curves.easeIn,
  //     switchOutCurve: Curves.easeOut,
  //     transitionBuilder: (Widget child, Animation<double> animation) {
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: Offset(showLoginForm ? 1.0 : -1.0, 0),
  //           end: Offset.zero,
  //         ).animate(animation),
  //         child: child,
  //       );
  //     },
  //     child: showLoginForm ? _buildLoginForm() : _buildResetPasswordForm(),
  //   );
  // }

  Widget _buildBottom() {
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
                  ? _buildLoginForm()
                  : _buildResetPasswordForm()),
        ),
      ),
    );
  }

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
        _buildResetButton(),
        const SizedBox(height: 150)
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bem Vindo",
          style: TextStyle(
              color: Colors.amber, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Realizar Login"),
        const SizedBox(height: 60),
        _buildGreyText("Email"),
        _buildInputField(emailController, false),
        const SizedBox(height: 40),
        _buildGreyText("Senha"),
        _buildInputField(passwordController, true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

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

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        setLoading(true);
        String email = emailController.text;
        String senha = passwordController.text;

        if (email.isEmpty || senha.isEmpty) {
          await Future.delayed(const Duration(milliseconds: 500));
          setLoading(false);
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text("Login Não Realizado"),
                );
              });
        } else {
          await Future.delayed(const Duration(milliseconds: 300));
          setLoading(false);
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text("Login Realizado"),
                );
              });
        }
      },
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

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: () async {
        setLoading(true);
        String email = emailController.text;

        if (email.isEmpty) {
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
                return const AlertDialog(
                  content: Text("Email Enviado"),
                );
              });
        }
      },
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
              Tab(icon: Image.asset("assets/images/facebook.png")),
            ],
          )
        ],
      ),
    );
  }
}
