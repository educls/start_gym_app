import 'package:http/http.dart' as http;

import '../utils/constants/constants.dart';

class FetchApi {
  final String route;
  final String body;
  final String method;

  const FetchApi({
    required this.route,
    this.body = '',
    required this.method,
  });

  Future<http.Response> fetch() async {
    String url = '${AppConstants.baseUrlApi}$route';
    try {
      http.Response response;
      if (method == 'POST') {
        response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );
      } else if (method == 'GET') {
        response = await http.get(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
      } else if (method == 'PUT') {
        response = await http.put(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        );
      } else if (method == 'DELETE') {
        response = await http.delete(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
      } else {
        throw Exception('Método de requisição inválido');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final responseData = json.decode(response.body);

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
