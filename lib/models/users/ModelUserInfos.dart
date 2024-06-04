// To parse this JSON data, do
//
//     final modelUserInfos = modelUserInfosFromMap(jsonString);

import 'dart:convert';

ModelUserInfos modelUserInfosFromMap(String str) => ModelUserInfos.fromMap(json.decode(str));

String modelUserInfosToMap(ModelUserInfos data) => json.encode(data.toMap());

class ModelUserInfos {
    String? id;
    String accounttype;
    dynamic teachertype;
    String? photo;
    String name;
    String? numberwhats;
    String email;
    String password;
    int? blocked;
    dynamic blockedAt;
    dynamic blockedUntil;
    int? loginAttempts;
    DateTime? createdAt;
    DateTime? updatedAt;

    ModelUserInfos({
        this.id,
        required this.accounttype,
        this.teachertype,
        this.photo,
        required this.name,
        this.numberwhats,
        required this.email,
        required this.password,
        this.blocked,
        this.blockedAt,
        this.blockedUntil,
        this.loginAttempts,
        this.createdAt,
        this.updatedAt,
    });

    factory ModelUserInfos.fromMap(Map<String, dynamic> json) => ModelUserInfos(
        id: json["id"],
        accounttype: json["accounttype"],
        teachertype: json["teachertype"],
        photo: json["photo"],
        name: json["name"],
        numberwhats: json["numberwhats"],
        email: json["email"],
        password: json["password"],
        blocked: json["blocked"],
        blockedAt: json["blocked_at"],
        blockedUntil: json["blocked_until"],
        loginAttempts: json["login_attempts"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "accounttype": accounttype,
        "teachertype": teachertype,
        "photo": photo,
        "name": name,
        "numberwhats": numberwhats,
        "email": email,
        "password": password,
        "blocked": blocked,
        "blocked_at": blockedAt,
        "blocked_until": blockedUntil,
        "login_attempts": loginAttempts,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
