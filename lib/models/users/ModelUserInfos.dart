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
  dynamic numberwhats;
  String email;
  String password;

  Mensagem({
    required this.id,
    required this.accounttype,
    required this.name,
    this.numberwhats,
    required this.email,
    required this.password,
  });

  factory Mensagem.fromMap(Map<String, dynamic> json) => Mensagem(
        id: json["id"],
        accounttype: json["accounttype"],
        name: json["name"],
        numberwhats: json["numberwhats"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accounttype": accounttype,
        "name": name,
        "email": email,
        "password": password,
      };
}
