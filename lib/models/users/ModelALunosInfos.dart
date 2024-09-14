// To parse this JSON data, do
//
//     final modelAlunosInfos = modelAlunosInfosFromMap(jsonString);

import 'dart:convert';

List<ModelAlunosInfos> modelAlunosInfosFromMap(String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList.map((json) => ModelAlunosInfos.fromMap(json)).toList();
}

String modelAlunosInfosToMap(ModelAlunosInfos data) =>
    json.encode(data.toMap());

class ModelAlunosInfos {
  String? id;
  String? nome;
  String? telefone;
  String? email;
  String? foto;

  ModelAlunosInfos({
    this.id,
    this.nome,
    this.telefone,
    this.email,
    this.foto,
  });

  factory ModelAlunosInfos.fromMap(Map<String, dynamic> json) =>
      ModelAlunosInfos(
        id: json["id"],
        nome: json["nome"],
        telefone: json["telefone"],
        email: json["email"],
        foto: json["foto"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "telefone": telefone,
        "email": email,
        "foto": foto,
      };
}
