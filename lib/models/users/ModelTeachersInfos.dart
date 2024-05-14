// To parse this JSON data, do
//
//     final modelTeachersInfos = modelTeachersInfosFromMap(jsonString);

import 'dart:convert';

List<ModelTeachersInfos> modelTeachersInfosFromMap(String str) {
  final Map<String, dynamic> jsonMap = json.decode(str);
  final List<dynamic> mensagemList = jsonMap['mensagem'];
  return mensagemList.map((json) => ModelTeachersInfos.fromMap(json)).toList();
}

String modelTeachersInfosToMap(List<ModelTeachersInfos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelTeachersInfos {
  int id;
  String name;
  String numberwhats;
  String? photo;

  ModelTeachersInfos({
    required this.id,
    required this.name,
    required this.numberwhats,
    this.photo,
  });

  factory ModelTeachersInfos.fromMap(Map<String, dynamic> json) =>
      ModelTeachersInfos(
        id: json["id"],
        name: json["name"],
        numberwhats: json["numberwhats"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "numberwhats": numberwhats,
        "photo": photo,
      };
}
