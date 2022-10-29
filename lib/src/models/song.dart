import 'package:youtube_music/src/models/album.dart';
import 'package:youtube_music/src/models/artist.dart';

class Song {
  Song({
    this.id,
    this.name,
    this.title,
    this.artists,
    this.album,
    this.duration,
    this.thumbnail,
  });

  final String? id;
  final String? name;
  final String? title;
  final List<Artist>? artists;
  final Album? album;
  final int? duration;
  final String? thumbnail;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        artists: json["artists"] == null
            ? null
            : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        duration: json["duration"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "artists": artists == null
            ? null
            : List<dynamic>.from(artists!.map((x) => x.toJson())),
        "album": album == null ? null : album!.toJson(),
        "duration": duration,
        "thumbnail": thumbnail,
      };
}
