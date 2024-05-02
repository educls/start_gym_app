// To parse this JSON data, do
//
//     final modelGetUser = modelGetUserFromMap(jsonString);

import 'dart:convert';

ModelGetUser modelGetUserFromMap(String str) =>
    ModelGetUser.fromMap(json.decode(str));

String modelGetUserToMap(ModelGetUser data) => json.encode(data.toMap());

class ModelGetUser {
  late ModelGetUser user;

  int id;
  String accounttype;
  String name;
  String email;
  String password;
  int iat;
  int exp;

  ModelGetUser({
    required this.id,
    required this.accounttype,
    required this.name,
    required this.email,
    required this.password,
    required this.iat,
    required this.exp,
  }) {
    user = ModelGetUser(
        id: id,
        accounttype: accounttype,
        name: name,
        email: email,
        password: password,
        iat: iat,
        exp: exp);
  }

  factory ModelGetUser.fromMap(Map<String, dynamic> json) => ModelGetUser(
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
