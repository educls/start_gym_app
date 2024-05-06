// To parse this JSON data, do
//
//     final modelUserInfos = modelUserInfosFromMap(jsonString);

import 'dart:convert';

ModelUserInfos modelUserInfosFromMap(String str) =>
    ModelUserInfos.fromMap(json.decode(str));

String modelUserInfosToMap(ModelUserInfos data) => json.encode(data.toMap());

class ModelUserInfos {
  Mensagem mensagem;
  String photo;

  ModelUserInfos({
    required this.mensagem,
    required this.photo,
  });

  factory ModelUserInfos.fromMap(Map<String, dynamic> json) => ModelUserInfos(
        mensagem: Mensagem.fromMap(json["mensagem"]),
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "mensagem": mensagem.toMap(),
        "photo": photo,
      };
}

class Mensagem {
  int id;
  String accounttype;
  String name;
  String email;
  String password;
  int iat;
  int exp;

  Mensagem({
    required this.id,
    required this.accounttype,
    required this.name,
    required this.email,
    required this.password,
    required this.iat,
    required this.exp,
  });

  factory Mensagem.fromMap(Map<String, dynamic> json) => Mensagem(
        id: json["id"],
        accounttype: json["accounttype"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accounttype": accounttype,
        "name": name,
        "email": email,
        "password": password,
        "iat": iat,
        "exp": exp,
      };
}
