// To parse this JSON data, do
//
//     final modelGetQuestionaryHistoricoAtividades = modelGetQuestionaryHistoricoAtividadesFromMap(jsonString);

import 'dart:convert';

List<ModelGetQuestionaryHistoricoAtividades>
    modelGetQuestionaryHistoricoAtividadesFromMap(String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList
      .map((json) => ModelGetQuestionaryHistoricoAtividades.fromMap(json))
      .toList();
}

String modelGetQuestionaryHistoricoAtividadesToMap(
        ModelGetQuestionaryHistoricoAtividades data) =>
    json.encode(data.toMap());

class ModelGetQuestionaryHistoricoAtividades {
  int? idAtividade;
  int? idUsuario;
  String? atividadeFisica;
  String? dieta;
  String? suplementos;
  String? fuma;
  String? bebidaAlcoolica;
  String? medicamentoControlado;
  String? cirurgia;
  DateTime? dataInsercao;

  ModelGetQuestionaryHistoricoAtividades({
    this.idAtividade,
    this.idUsuario,
    this.atividadeFisica,
    this.dieta,
    this.suplementos,
    this.fuma,
    this.bebidaAlcoolica,
    this.medicamentoControlado,
    this.cirurgia,
    this.dataInsercao,
  });

  factory ModelGetQuestionaryHistoricoAtividades.fromMap(
          Map<String, dynamic> json) =>
      ModelGetQuestionaryHistoricoAtividades(
        idAtividade: json["id_atividade"],
        idUsuario: json["id_usuario"],
        atividadeFisica: json["atividade_fisica"],
        dieta: json["dieta"],
        suplementos: json["suplementos"],
        fuma: json["fuma"],
        bebidaAlcoolica: json["bebida_alcoolica"],
        medicamentoControlado: json["medicamento_controlado"],
        cirurgia: json["cirurgia"],
        dataInsercao: json["data_insercao"] == null
            ? null
            : DateTime.parse(json["data_insercao"]),
      );

  Map<String, dynamic> toMap() => {
        "id_atividade": idAtividade,
        "id_usuario": idUsuario,
        "atividade_fisica": atividadeFisica,
        "dieta": dieta,
        "suplementos": suplementos,
        "fuma": fuma,
        "bebida_alcoolica": bebidaAlcoolica,
        "medicamento_controlado": medicamentoControlado,
        "cirurgia": cirurgia,
        "data_insercao": dataInsercao?.toIso8601String(),
      };
}
