// To parse this JSON data, do
//
//     final modelGetQuestionaryHistoricoDoencas = modelGetQuestionaryHistoricoDoencasFromMap(jsonString);

import 'dart:convert';

List<ModelGetQuestionaryHistoricoDoencas>
    modelGetQuestionaryHistoricoDoencasFromMap(String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList
      .map((json) => ModelGetQuestionaryHistoricoDoencas.fromMap(json))
      .toList();
}

String modelGetQuestionaryHistoricoDoencasToMap(
        ModelGetQuestionaryHistoricoDoencas data) =>
    json.encode(data.toMap());

class ModelGetQuestionaryHistoricoDoencas {
  int? idDoenca;
  int? idUsuario;
  String? doencas;
  String? dores;
  String? adicional;
  DateTime? dataInsercao;

  ModelGetQuestionaryHistoricoDoencas({
    this.idDoenca,
    this.idUsuario,
    this.doencas,
    this.dores,
    this.adicional,
    this.dataInsercao,
  });

  factory ModelGetQuestionaryHistoricoDoencas.fromMap(
          Map<String, dynamic> json) =>
      ModelGetQuestionaryHistoricoDoencas(
        idDoenca: json["id_doenca"],
        idUsuario: json["id_usuario"],
        doencas: json["doencas"],
        dores: json["dores"],
        adicional: json["adicional"],
        dataInsercao: json["data_insercao"] == null
            ? null
            : DateTime.parse(json["data_insercao"]),
      );

  Map<String, dynamic> toMap() => {
        "id_doenca": idDoenca,
        "id_usuario": idUsuario,
        "doencas": doencas,
        "dores": dores,
        "adicional": adicional,
        "data_insercao": dataInsercao?.toIso8601String(),
      };
}
