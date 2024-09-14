import 'package:http/http.dart' as http;
import 'package:start_gym_app/services/req_api_class.dart';

class FetchApiUsers {
  Future<http.Response> fetchLoginUsers(loginData) async {
    http.Response resp =
        await FetchApi(route: '/login', method: 'POST', body: loginData)
            .fetch();
    return resp;
  }

  Future<http.Response> fetchSignUpForUsers(dataForSignUp) async {
    http.Response resp =
        await FetchApi(route: '/usuarios', method: 'POST', body: dataForSignUp)
            .fetch();
    return resp;
  }

  Future<http.Response> fetchSendEmailForReset(sendEmailData) async {
    http.Response resp = await FetchApi(
            route: '/send-email-reset-password',
            method: 'POST',
            body: sendEmailData)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchForSendEmailForVerifyEmail(sendEmailData) async {
    http.Response resp = await FetchApi(
            route: '/verifica-email', method: 'POST', body: sendEmailData)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchForCheckIfEmailWasVerified(email) async {
    http.Response resp = await FetchApi(
            route: '/check-if-email-is-verified/$email', method: 'GET')
        .fetch();
    return resp;
  }

  Future<http.Response> fetchForDeleteEmailIsAboutVerified(email) async {
    http.Response resp = await FetchApi(
            route: '/check-if-email-is-verified/$email', method: 'DELETE')
        .fetch();
    return resp;
  }

  Future<http.Response> fetchInfosUser(token) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/get-user-info', method: 'GET', authToken: token)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchTeachersInfos(token) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/get-info-professores',
            method: 'GET',
            authToken: token)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchAlunosInfos(token) async {
    http.Response resp = await FetchApi(
      route: '/usuarios/get-info-alunos',
      method: 'GET',
      authToken: token,
    ).fetch();
    print(resp.body);
    return resp;
  }

  Future<http.Response> fetchSignUpNewTeacher(data, userToken) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/sign-up-professor',
            method: 'POST',
            authToken: userToken,
            body: data)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchSignUpNewAluno(
      String name, String email, String password, String userToken) async {
    http.Response resp = await FetchApi(
      route: '/verifica-email/$userToken/$name/$email/$password',
      method: 'GET',
      authToken: userToken,
    ).fetch();
    return resp;
  }

  Future<http.Response> fetchEditUser(data, userToken) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/edit-user',
            method: 'PUT',
            authToken: userToken,
            body: data)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchQuestionary(data, userToken, type) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/send-questionary/$type',
            method: 'POST',
            authToken: userToken,
            body: data)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchListImagesMinhaEvolucao(
      data, userToken, type) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/send-questionary/$type',
            method: 'POST',
            authToken: userToken,
            body: data)
        .fetch();
    return resp;
  }

  Future<http.Response> fetchGetQuestionary(userToken, type) async {
    http.Response resp = await FetchApi(
            route: '/usuarios/get-questionary/$type',
            method: 'GET',
            authToken: userToken)
        .fetch();
    return resp;
  }
}
