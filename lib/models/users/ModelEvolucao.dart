import 'dart:convert';

ModelQuestionEvolucao modelQuestionEvolucaoFromJson(String str) =>
    ModelQuestionEvolucao.fromJson(json.decode(str));

String modelQuestionEvolucaoToJson(ModelQuestionEvolucao data) =>
    json.encode(data.toJson());

class ModelQuestionEvolucao {
  String? foto1;
  String? foto2;
  String? foto3;

  ModelQuestionEvolucao({
    this.foto1,
    this.foto2,
    this.foto3,
  });

  factory ModelQuestionEvolucao.fromJson(Map<String, dynamic> json) =>
      ModelQuestionEvolucao(
        foto1: json["Foto1"],
        foto2: json["Foto2"],
        foto3: json["Foto3"],
      );

  Map<String, dynamic> toJson() => {
        "Foto1": foto1,
        "Foto2": foto2,
        "Foto3": foto3,
      };
}
