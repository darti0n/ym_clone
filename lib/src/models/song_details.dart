// To parse this JSON data, do
//
//     final songDetails = songDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:youtube_music/src/models/song_details_result.dart';

SongDetails songDetailsFromJson(String str) =>
    SongDetails.fromJson(json.decode(str));

String songDetailsToJson(SongDetails data) => json.encode(data.toJson());

class SongDetails {
  SongDetails({
    this.ok,
    this.result,
  });

  final bool? ok;
  final SongDetailsResult? result;

  factory SongDetails.fromJson(Map<String, dynamic> json) => SongDetails(
        ok: json["ok"],
        result: json["result"] == null
            ? null
            : SongDetailsResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "result": result == null ? null : result?.toJson(),
      };
}
