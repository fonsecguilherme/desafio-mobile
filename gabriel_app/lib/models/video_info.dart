import 'dart:convert';

class VideoInfo {
  final String title;
  final String subtitle;
  final String description;

  VideoInfo({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  VideoInfo copyWith({
    String? title,
    String? subtitle,
    String? description,
  }) =>
      VideoInfo(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        description: description ?? this.description,
      );

  factory VideoInfo.fromJson(String str) => VideoInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoInfo.fromMap(Map<String, dynamic> json) => VideoInfo(
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "subtitle": subtitle,
        "description": description,
      };
}
