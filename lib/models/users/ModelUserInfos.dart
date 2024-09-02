// To parse this JSON data, do
//
//     final modelUserInfos = modelUserInfosFromMap(jsonString);

import 'dart:convert';

ModelUserInfos modelUserInfosFromMap(String str) => ModelUserInfos.fromMap(json.decode(str));

String modelUserInfosToMap(ModelUserInfos data) => json.encode(data.toMap());

class ModelUserInfos {
    String id_usuario;
    String tipo_usuario;
    String? foto;
    String nome;
    String? telefone;
    String email;
    String password;
    int bloqueado;
    DateTime? bloqueado_em;
    DateTime? bloqueado_ate;
    DateTime? data_nascimento;
    int? login_tentativas;
    DateTime? criado_em;
    DateTime? atualizado_em;

    ModelUserInfos({
        required this.id_usuario,
        required this.tipo_usuario,
        this.foto,
        required this.nome,
        this.telefone,
        required this.email,
        required this.password,
        required this.bloqueado,
        this.bloqueado_em,
        this.bloqueado_ate,
        this.data_nascimento,
        this.login_tentativas,
        this.criado_em,
        this.atualizado_em,
    });

    factory ModelUserInfos.fromMap(Map<String, dynamic> json) => ModelUserInfos(
        id_usuario: json["id_usuario"].toString(),
        tipo_usuario: json["tipo_usuario"] ?? "",
        foto: json["foto"],
        nome: json["nome"] ?? "",
        telefone: json["telefone"],
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        bloqueado: json["bloqueado"] ?? 0,
        bloqueado_em: json["bloqueado_em"] == null ? null : DateTime.parse(json["bloqueado_em"]),
        bloqueado_ate: json["bloqueado_ate"] == null ? null : DateTime.parse(json["bloqueado_ate"]),
        data_nascimento: json["data_nascimento"] == null ? null : DateTime.parse(json["data_nascimento"]),
        login_tentativas: json["login_tentativas"] ?? 0,
        criado_em: json["criado_em"] == null ? null : DateTime.parse(json["criado_em"]),
        atualizado_em: json["atualizado_em"] == null ? null : DateTime.parse(json["atualizado_em"]),
    );

    Map<String, dynamic> toMap() => {
        "id_usuario": id_usuario,
        "tipo_usuario": tipo_usuario,
        "foto": foto,
        "nome": nome,
        "telefone": telefone,
        "email": email,
        "password": password,
        "bloqueado": bloqueado,
        "bloqueado_em": bloqueado_em?.toIso8601String(),
        "bloqueado_ate": bloqueado_ate?.toIso8601String(),
        "data_nascimento": data_nascimento?.toIso8601String(),
        "login_tentativas": login_tentativas,
        "criado_em": criado_em?.toIso8601String(),
        "atualizado_em": atualizado_em?.toIso8601String(),
    };
}

