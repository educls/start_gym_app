// To parse this JSON data, do
//
//     final modelSignUpTeacher = modelSignUpTeacherFromJson(jsonString);

import 'dart:convert';

ModelSignUpTeacher modelSignUpTeacherFromJson(String str) =>
    ModelSignUpTeacher.fromJson(json.decode(str));

String modelSignUpTeacherToJson(ModelSignUpTeacher data) =>
    json.encode(data.toJson());

class ModelSignUpTeacher {
  String name;
  String email;
  String password;
  String teachertype;

  ModelSignUpTeacher({
    required this.name,
    required this.email,
    required this.password,
    required this.teachertype,
  });

  factory ModelSignUpTeacher.fromJson(Map<String, dynamic> json) =>
      ModelSignUpTeacher(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        teachertype: json["teachertype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "teachertype": teachertype,
      };
}
