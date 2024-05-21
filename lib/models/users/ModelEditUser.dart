// To parse this JSON data, do
//
//     final modelEditUser = modelEditUserFromJson(jsonString);

import 'dart:convert';

ModelEditUser modelEditUserFromJson(String str) =>
    ModelEditUser.fromJson(json.decode(str));

String modelEditUserToJson(ModelEditUser data) => json.encode(data.toJson());

class ModelEditUser {
  String? name;
  String? photo;
  String? numWhats;
  String? email;
  String? password;

  ModelEditUser({
    this.name,
    this.photo,
    this.numWhats,
    this.email,
    this.password,
  });

  factory ModelEditUser.fromJson(Map<String, dynamic> json) => ModelEditUser(
        name: json["name"],
        photo: json["photo"],
        numWhats: json["numWhats"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "photo": photo,
        "numWhats": numWhats,
        "email": email,
        "password": password,
      };
}
