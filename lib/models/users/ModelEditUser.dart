// To parse this JSON data, do
//
//     final modelEditUser = modelEditUserFromJson(jsonString);

import 'dart:convert';

ModelEditUser modelEditUserFromJson(String str) =>
    ModelEditUser.fromJson(json.decode(str));

String modelEditUserToJson(ModelEditUser data) => json.encode(data.toJson());

class ModelEditUser {
  String? photo;
  String? name;
  String? numWhats;
  String? email;
  String? password;

  ModelEditUser({
    this.photo,
    this.name,
    this.numWhats,
    this.email,
    this.password,
  });

  factory ModelEditUser.fromJson(Map<String, dynamic> json) => ModelEditUser(
        photo: json["photo"],
        name: json["name"],
        numWhats: json["numWhats"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "name": name,
        "numWhats": numWhats,
        "email": email,
        "password": password,
      };
}
