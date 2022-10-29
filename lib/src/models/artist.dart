class Artist {
  Artist({
    this.artistId,
    this.name,
  });

  final String? artistId;
  final String? name;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        artistId: json["artist_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "artist_id": artistId,
        "name": name,
      };
}
