// To parse this JSON data, do
//
//     final musicObjects = musicObjectsFromJson(jsonString);

import 'dart:convert';

import 'package:youtube_music/src/models/result.dart';

MusicObjects musicObjectsFromJson(String str) =>
    MusicObjects.fromJson(json.decode(str));

String musicObjectsToJson(MusicObjects data) => json.encode(data.toJson());

class MusicObjects {
  MusicObjects({
    this.ok,
    this.result,
  });

  final bool? ok;
  final Result? result;

  factory MusicObjects.fromJson(Map<String, dynamic> json) => MusicObjects(
        ok: json["ok"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "result": result == null ? null : result!.toJson(),
      };
}
