import 'package:http/http.dart' as http;

import '../../models/users/LoginModel.dart';
import '../../models/users/SendEmailForResetModel.dart';
import '../../models/users/SignUpModel.dart';
import '../../services/users/users_service.dart';

FetchApiUsers fetchApiUsers = FetchApiUsers();

Future<http.Response> userLogin(String email, String password) async {
  var dataForLogin =
      userLoginToJson(UserLogin(email: email, password: password));

  http.Response response = await fetchApiUsers.fetchLoginUsers(dataForLogin);

  return response;
}

Future<http.Response> userSignUp(String accountType, String photo, String name,
    String numWhats, String email, String password) async {
  var dataForSignUp = signUpModelToJson(SignUpModel(
      accountType: accountType,
      photo: photo,
      name: name,
      numWhats: numWhats,
      email: email,
      password: password));

  http.Response response =
      await fetchApiUsers.fetchSignUpForUsers(dataForSignUp);

  return response;
}

Future<http.Response> userSendEmailForResetPassword(String email) async {
  var dataBySendEmail =
      sendEmailForResetToJson(SendEmailForReset(email: email));

  http.Response response =
      await fetchApiUsers.fetchSendEmailForReset(dataBySendEmail);

  return response;
}

Future<http.Response> checkIfEmailIsVerified(String email) async {
  http.Response response =
      await fetchApiUsers.fetchForCheckIfEmailWasVerified(email);

  return response;
}

Future<http.Response> deleteEmailIsAboutVerified(String email) async {
  http.Response response =
      await fetchApiUsers.fetchForDeleteEmailIsAboutVerified(email);

  return response;
}

Future<http.Response> sendEmailForVerifiedEmail(String email) async {
  var sendEmailData = sendEmailForResetToJson(SendEmailForReset(email: email));

  http.Response response =
      await fetchApiUsers.fetchForSendEmailForVerifyEmail(sendEmailData);

  return response;
}

Future<http.Response> getInformationsUser(String token) async {
  http.Response response = await fetchApiUsers.fetchInfosUser(token);

  return response;
}
