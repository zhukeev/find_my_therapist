// To parse this JSON data, do
//
//     final recomendedTherapy = recomendedTherapyFromJson(jsonString);

import 'dart:convert';

RecomendedTherapy recomendedTherapyFromJson(String str) =>
    RecomendedTherapy.fromJson(json.decode(str));

String recomendedTherapyToJson(RecomendedTherapy data) =>
    json.encode(data.toJson());

class RecomendedTherapy {
  RecomendedTherapy({
    this.errors,
    this.code,
    this.message,
    this.additional,
    this.data,
  });

  bool errors;
  dynamic code;
  dynamic message;
  List<dynamic> additional;
  Data data;

  factory RecomendedTherapy.fromJson(Map<String, dynamic> json) =>
      RecomendedTherapy(
        errors: json["errors"],
        code: json["code"],
        message: json["message"],
        additional: List<dynamic>.from(json["additional"].map((x) => x)),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "code": code,
        "message": message,
        "additional": List<dynamic>.from(additional.map((x) => x)),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.title,
    this.description,
  });

  int id;
  String title;
  String description;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
