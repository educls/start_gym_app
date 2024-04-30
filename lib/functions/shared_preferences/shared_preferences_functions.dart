import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFunctions {
  void saveCredentialsForSignUpAndEmailConfirmation(
    String base64Image,
    TextEditingController txtName,
    TextEditingController txtNumero,
    TextEditingController txtEmail,
    TextEditingController txtPassword,
    TextEditingController txtConfirmPassword,
    bool waitConfirmationEmail,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('photoSignUp', base64Image);
    prefs.setString('nameSignUp', txtName.text);
    prefs.setString('numberSignUp', txtNumero.text);
    prefs.setString('emailSignUp', txtEmail.text);
    prefs.setString('passwordSignUp', txtPassword.text);
    prefs.setString('passwordConfirmSignUp', txtConfirmPassword.text);
    prefs.setBool('waitingConfirmation', waitConfirmationEmail);
  }

  void deleteCredentialsForSignUpAndEmailConfirmation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('photoSignUp');
    await prefs.remove('nameSignUp');
    await prefs.remove('numberSignUp');
    await prefs.remove('emailSignUp');
    await prefs.remove('passwordSignUp');
    await prefs.remove('passwordConfirmSignUp');
    await prefs.remove('waitingConfirmation');
  }
}
