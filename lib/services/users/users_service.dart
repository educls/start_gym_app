import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants/constants.dart';

class FetchApiUsers {
  Future<http.Response> fetchLoginUsers(loginData) async {
    String url = '${AppConstants.baseUrlApi}/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: loginData,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        return response;
      } else {
        print('Falha na requisição: ${response.statusCode}');

        return response;
      }
    } catch (err) {
      print('Erro na requisição: $err');
      return http.Response('Erro na requisição: $err', 500);
    }
  }

  Future<http.Response> fetchSendEmailForReset(data) async {
    String url = '${AppConstants.baseUrlApi}/send-email-reset-password';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        return response;
      } else {
        print('Falha na requisição: ${response.statusCode}');

        return response;
      }
    } catch (err) {
      print('Erro na requisição: $err');
      return http.Response('Erro na requisição: $err', 500);
    }
  }
}
