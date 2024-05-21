// To parse this JSON data, do
//
//     final modelGetQuestionaryMinhaEvolucao = modelGetQuestionaryMinhaEvolucaoFromMap(jsonString);

import 'dart:convert';

List<ModelGetQuestionaryMinhaEvolucao> modelGetQuestionaryMinhaEvolucaoFromMap(
    String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList
      .map((json) => ModelGetQuestionaryMinhaEvolucao.fromMap(json))
      .toList();
}

String modelGetQuestionaryMinhaEvolucaoToMap(
        ModelGetQuestionaryMinhaEvolucao data) =>
    json.encode(data.toMap());

class ModelGetQuestionaryMinhaEvolucao {
  int? idEvolucao;
  int? idUsuario;
  String? foto1;
  String? foto2;
  String? foto3;
  String? dataInsercao;

  ModelGetQuestionaryMinhaEvolucao({
    this.idEvolucao,
    this.idUsuario,
    this.foto1,
    this.foto2,
    this.foto3,
    this.dataInsercao,
  });

  factory ModelGetQuestionaryMinhaEvolucao.fromMap(Map<String, dynamic> json) =>
      ModelGetQuestionaryMinhaEvolucao(
        idEvolucao: json["id_evolucao"],
        idUsuario: json["id_usuario"],
        foto1: json["foto1"],
        foto2: json["foto2"],
        foto3: json["foto3"],
        dataInsercao: json["data_insercao"],
      );

  Map<String, dynamic> toMap() => {
        "id_evolucao": idEvolucao,
        "id_usuario": idUsuario,
        "foto1": foto1,
        "foto2": foto2,
        "foto3": foto3,
        "data_insercao": dataInsercao,
      };
}
