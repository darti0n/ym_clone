class Video {
  Video({
    this.id,
    this.title,
    this.duration,
  });

  final String? id;
  final String? title;
  final int? duration;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "duration": duration,
      };
}
