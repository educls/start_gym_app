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
  String? name;
  String? numberwhats;
  String? email;
  String? photo;

  ModelAlunosInfos({
    this.id,
    this.name,
    this.numberwhats,
    this.email,
    this.photo,
  });

  factory ModelAlunosInfos.fromMap(Map<String, dynamic> json) =>
      ModelAlunosInfos(
        id: json["id"],
        name: json["name"],
        numberwhats: json["numberwhats"],
        email: json["email"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "numberwhats": numberwhats,
        "email": email,
        "photo": photo,
      };
}
