// To parse this JSON data, do
//
//     final modelEditUser = modelEditUserFromJson(jsonString);

import 'dart:convert';

ModelEditUser modelEditUserFromJson(String str) =>
    ModelEditUser.fromJson(json.decode(str));

String modelEditUserToJson(ModelEditUser data) => json.encode(data.toJson());

class ModelEditUser {
  String? nome;
  String? foto;
  String? telefone;
  String? email;
  String? password;

  ModelEditUser({
    this.nome,
    this.foto,
    this.telefone,
    this.email,
    this.password,
  });

  factory ModelEditUser.fromJson(Map<String, dynamic> json) => ModelEditUser(
        nome: json["nome"],
        foto: json["foto"],
        telefone: json["telefone"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "foto": foto,
        "telefone": telefone,
        "email": email,
        "password": password,
      };
}
