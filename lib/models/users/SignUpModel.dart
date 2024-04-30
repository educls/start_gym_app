// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  String accountType;
  String photo;
  String name;
  String numWhats;
  String email;
  String password;

  SignUpModel({
    required this.accountType,
    required this.photo,
    required this.name,
    required this.numWhats,
    required this.email,
    required this.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        accountType: json["accountType"],
        photo: json["photo"],
        name: json["name"],
        numWhats: json["numWhats"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "accountType": accountType,
        "photo": photo,
        "name": name,
        "numWhats": numWhats,
        "email": email,
        "password": password,
      };
}
