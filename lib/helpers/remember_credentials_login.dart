import 'package:shared_preferences/shared_preferences.dart';

class RememberCredentials {
  saveCredentialsAndPreferences(String email, String password, bool rememberUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('rememberUser', rememberUser);
  }
}