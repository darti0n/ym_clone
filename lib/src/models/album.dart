class Album {
  Album({
    this.albumId,
    this.name,
  });

  final String? albumId;
  final String? name;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        albumId: json["album_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "album_id": albumId,
        "name": name,
      };
}
