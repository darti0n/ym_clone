import 'package:youtube_music/src/models/song.dart';
import 'package:youtube_music/src/models/video.dart';

class Result {
  Result({
    this.songs,
    this.videos,
  });

  final List<Song>? songs;
  final List<Video>? videos;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        songs: json["songs"] == null
            ? null
            : List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
        videos: json["videos"] == null
            ? null
            : List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "songs": songs == null
            ? null
            : List<dynamic>.from(songs!.map((x) => x.toJson())),
        "videos": videos == null
            ? null
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}
