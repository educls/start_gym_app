import 'package:http/http.dart' as http;

import '../../models/users/LoginModel.dart';
import '../../models/users/SendEmailForResetModel.dart';
import '../../services/users/users_service.dart';

FetchApiUsers fetchApiUsers = FetchApiUsers();

Future<http.Response> userLogin(String email, String password) async {
  var dataForLogin =
      userLoginToJson(UserLogin(email: email, password: password));

  http.Response response = await fetchApiUsers.fetchLoginUsers(dataForLogin);

  return response;
}

Future<http.Response> userSendEmailForResetPassword(String email) async {
  var dataBySendEmail =
      sendEmailForResetToJson(SendEmailForReset(email: email));

  http.Response response =
      await fetchApiUsers.fetchSendEmailForReset(dataBySendEmail);

  return response;
}
