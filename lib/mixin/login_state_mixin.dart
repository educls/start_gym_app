import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin LoginStateHelpers<T extends StatefulWidget> on State<T> {

  late Color myColor = Theme.of(context).primaryColor;
  late Size mediaSize = MediaQuery.of(context).size;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool isObscurePassword = true;
  bool showLoginForm = true;
  bool isLoading = false;
  int attempts = 0;
  late int remainingTimeInSeconds = 60;
  late int remainingTimeInSecondsBlock = 60;
  bool emailSend = false;
  bool waitingConfirmation = false;

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

  void setLoading(bool setLoading) {
    setState(() {
      isLoading = setLoading;
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

  void startTimer() {
    remainingTimeInSecondsBlock = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTimeInSecondsBlock > 0) {
          remainingTimeInSecondsBlock--;
        } else {
          timer.cancel();
          attempts = 0;
        }
      });
    });
  }

  void startTimerForResetPassword() {
    remainingTimeInSeconds = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(
        () {
          if (remainingTimeInSeconds > 0) {
            remainingTimeInSeconds--;
          } else {
            timer.cancel();
            setState(() {
              emailSend = false;
              remainingTimeInSeconds = 60;
            });
          }
        },
      );
    });
  }

  Future<void> loadSavedCredentials() async {
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

  Future<void> saveCredentialsAndPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
    prefs.setString('password', passwordController.text);
    prefs.setBool('rememberUser', rememberUser);
  }

  void setRememberUser(bool yesOrNot) {
    setState(() {
      rememberUser = yesOrNot;
    });
  }
}