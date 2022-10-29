class SongDetailsResult {
  SongDetailsResult({
    this.downloadUrl,
  });

  final String? downloadUrl;

  factory SongDetailsResult.fromJson(Map<String, dynamic> json) =>
      SongDetailsResult(
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "download_url": downloadUrl,
      };
}
