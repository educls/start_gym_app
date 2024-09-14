import 'package:flutter/material.dart';
import 'package:start_gym_app/mixin/login_state_mixin.dart';
import 'package:start_gym_app/utils/constants/color_constants.dart';
import 'package:start_gym_app/widgets/custom_loading.dart';

import '../../widgets/forms/custom_build_login_form.dart';
import '../../widgets/forms/custom_build_resetpass_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginStateHelpers<LoginPage> {
  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.darkBlue,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(myColor.withOpacity(0.25), BlendMode.dstATop),
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
                if (isLoading)
                  const CustomLoading(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 00,
            child: _buildBottom(context),
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom(context) {
    return showLoginForm
        ? BuildLoginForm(
            isLoading: isLoading,
            setLoading: setLoading,
            toggleForm: toggleForm,
          )
        : BuildResetPassForm(
            toggleForm: toggleForm,
            setLoading: setLoading,
            isLoading: isLoading,
          );
  }
}
