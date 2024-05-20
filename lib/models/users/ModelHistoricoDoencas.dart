import 'dart:convert';

ModelQuestionHistoricoDoencas modelQuestionHistoricoDoencasFromJson(
        String str) =>
    ModelQuestionHistoricoDoencas.fromJson(json.decode(str));

String modelQuestionHistoricoDoencasToJson(
        ModelQuestionHistoricoDoencas data) =>
    json.encode(data.toJson());

class ModelQuestionHistoricoDoencas {
  String? doencas;
  String? dores;
  String? adicional;

  ModelQuestionHistoricoDoencas({
    this.doencas,
    this.dores,
    this.adicional,
  });

  factory ModelQuestionHistoricoDoencas.fromJson(Map<String, dynamic> json) =>
      ModelQuestionHistoricoDoencas(
        doencas: json["Doencas"],
        dores: json["Dores"],
        adicional: json["Adicional"],
      );

  Map<String, dynamic> toJson() => {
        "Doencas": doencas,
        "Dores": dores,
        "Adicional": adicional,
      };
}
