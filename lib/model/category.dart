// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
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
  List<Datum> data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        errors: json["errors"],
        code: json["code"],
        message: json["message"],
        additional: List<dynamic>.from(json["additional"].map((x) => x)),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "code": code,
        "message": message,
        "additional": List<dynamic>.from(additional.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.clientCategoryId,
    this.order,
    this.title,
    this.ageRange,
  });

  int clientCategoryId;
  int order;
  String title;
  String ageRange;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        clientCategoryId: json["client_category_id"],
        order: json["order"],
        title: json["title"],
        ageRange: json["age_range"],
      );

  Map<String, dynamic> toJson() => {
        "client_category_id": clientCategoryId,
        "order": order,
        "title": title,
        "age_range": ageRange,
      };
}
