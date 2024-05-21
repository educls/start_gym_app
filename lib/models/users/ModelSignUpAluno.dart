// To parse this JSON data, do
//
//     final modelSignUpAluno = modelSignUpAlunoFromJson(jsonString);

import 'dart:convert';

ModelSignUpAluno modelSignUpAlunoFromJson(String str) =>
    ModelSignUpAluno.fromJson(json.decode(str));

String modelSignUpAlunoToJson(ModelSignUpAluno data) =>
    json.encode(data.toJson());

class ModelSignUpAluno {
  String? name;
  String? email;
  String? password;

  ModelSignUpAluno({
    this.name,
    this.email,
    this.password,
  });

  factory ModelSignUpAluno.fromJson(Map<String, dynamic> json) =>
      ModelSignUpAluno(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
