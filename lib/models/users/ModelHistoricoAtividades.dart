import 'dart:convert';

ModelQuestionHistoricoAtividades modelQuestionHistoricoAtividadesFromJson(
        String str) =>
    ModelQuestionHistoricoAtividades.fromJson(json.decode(str));

String modelQuestionHistoricoAtividadesToJson(
        ModelQuestionHistoricoAtividades data) =>
    json.encode(data.toJson());

class ModelQuestionHistoricoAtividades {
  String? atividadeFisica;
  String? dieta;
  String? suplementos;
  String? fuma;
  String? bebidaAlcoolica;
  String? medicamentoControlado;
  String? cirurgia;

  ModelQuestionHistoricoAtividades({
    this.atividadeFisica,
    this.dieta,
    this.suplementos,
    this.fuma,
    this.bebidaAlcoolica,
    this.medicamentoControlado,
    this.cirurgia,
  });

  factory ModelQuestionHistoricoAtividades.fromJson(
          Map<String, dynamic> json) =>
      ModelQuestionHistoricoAtividades(
        atividadeFisica: json["AtividadeFisica"],
        dieta: json["Dieta"],
        suplementos: json["Suplementos"],
        fuma: json["Fuma"],
        bebidaAlcoolica: json["BebidaAlcoolica"],
        medicamentoControlado: json["MedicamentoControlado"],
        cirurgia: json["Cirurgia"],
      );

  Map<String, dynamic> toJson() => {
        "AtividadeFisica": atividadeFisica,
        "Dieta": dieta,
        "Suplementos": suplementos,
        "Fuma": fuma,
        "BebidaAlcoolica": bebidaAlcoolica,
        "MedicamentoControlado": medicamentoControlado,
        "Cirurgia": cirurgia,
      };
}
