import 'dart:convert';

ModelQuestionAvaliacaoFisica modelQuestionAvaliacaoFisicaFromJson(String str) =>
    ModelQuestionAvaliacaoFisica.fromJson(json.decode(str));

String modelQuestionAvaliacaoFisicaToJson(ModelQuestionAvaliacaoFisica data) =>
    json.encode(data.toJson());

class ModelQuestionAvaliacaoFisica {
  String? objetivos;
  String? peso;
  String? altura;
  String? nascimento;

  ModelQuestionAvaliacaoFisica({
    this.objetivos,
    this.peso,
    this.altura,
    this.nascimento,
  });

  factory ModelQuestionAvaliacaoFisica.fromJson(Map<String, dynamic> json) =>
      ModelQuestionAvaliacaoFisica(
        objetivos: json["Objetivos"],
        peso: json["Peso"],
        altura: json["Altura"],
        nascimento: json["Nascimento"],
      );

  Map<String, dynamic> toJson() => {
        "Objetivos": objetivos,
        "Peso": peso,
        "Altura": altura,
        "Nascimento": nascimento,
      };
}
