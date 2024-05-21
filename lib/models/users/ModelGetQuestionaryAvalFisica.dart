// To parse this JSON data, do
//
//     final modelGetQuestionaryInfos = modelGetQuestionaryInfosFromMap(jsonString);

import 'dart:convert';

List<ModelGetQuestionaryAvaliacaoFisica> modelGetQuestionaryInfosFromMap(
    String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList
      .map((json) => ModelGetQuestionaryAvaliacaoFisica.fromMap(json))
      .toList();
}

String modelGetQuestionaryInfosToMap(
        List<ModelGetQuestionaryAvaliacaoFisica> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelGetQuestionaryAvaliacaoFisica {
  int? idAvaliacao;
  int? idUsuario;
  String? objetivos;
  String? peso;
  String? altura;
  DateTime? nascimento;
  DateTime? dataInsercao;

  ModelGetQuestionaryAvaliacaoFisica({
    this.idAvaliacao,
    this.idUsuario,
    this.objetivos,
    this.peso,
    this.altura,
    this.nascimento,
    this.dataInsercao,
  });

  factory ModelGetQuestionaryAvaliacaoFisica.fromMap(
          Map<String, dynamic> json) =>
      ModelGetQuestionaryAvaliacaoFisica(
        idAvaliacao: json["id_avaliacao"],
        idUsuario: json["id_usuario"],
        objetivos: json["objetivos"],
        peso: json["peso"],
        altura: json["altura"],
        nascimento: json["nascimento"] == null
            ? null
            : DateTime.parse(json["nascimento"]),
        dataInsercao: json["data_insercao"] == null
            ? null
            : DateTime.parse(json["data_insercao"]),
      );

  Map<String, dynamic> toMap() => {
        "id_avaliacao": idAvaliacao,
        "id_usuario": idUsuario,
        "objetivos": objetivos,
        "peso": peso,
        "altura": altura,
        "nascimento": nascimento?.toIso8601String(),
        "data_insercao": dataInsercao?.toIso8601String(),
      };
}
