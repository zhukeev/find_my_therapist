// To parse this JSON data, do
//
//     final problem = problemFromJson(jsonString);

import 'dart:convert';

Problem problemFromJson(String str) => Problem.fromJson(json.decode(str));

String problemToJson(Problem data) => json.encode(data.toJson());

class Problem {
  Problem({
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

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
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
    this.id,
    this.title,
    this.issues,
  });

  int id;
  String title;
  List<Issue> issues;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        issues: json["issues"] == null
            ? null
            : List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "issues": issues == null
            ? null
            : List<dynamic>.from(issues.map((x) => x.toJson())),
      };
}

class Issue {
  Issue({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
