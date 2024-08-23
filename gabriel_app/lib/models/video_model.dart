import 'dart:convert';

import 'location_info_model.dart';
import 'video_info.dart';

class VideoModel {
  final List<Video> data;

  VideoModel({
    required this.data,
  });

  VideoModel copyWith({
    List<Video>? data,
  }) =>
      VideoModel(
        data: data ?? this.data,
      );

  factory VideoModel.fromJson(String str) =>
      VideoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoModel.fromMap(Map<String, dynamic> json) => VideoModel(
        data: List<Video>.from(json["data"].map((x) => Video.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Video {
  final String uri;
  final String fileName;
  final VideoInfo videoInfo;
  final LocationInfo locationInfo;

  Video({
    required this.uri,
    required this.fileName,
    required this.videoInfo,
    required this.locationInfo,
  });

  Video copyWith({
    String? uri,
    String? fileName,
    VideoInfo? videoInfo,
    LocationInfo? locationInfo,
  }) =>
      Video(
        uri: uri ?? this.uri,
        fileName: fileName ?? this.fileName,
        videoInfo: videoInfo ?? this.videoInfo,
        locationInfo: locationInfo ?? this.locationInfo,
      );

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
        uri: json["uri"],
        fileName: json["fileName"],
        videoInfo: VideoInfo.fromMap(json["videoInfo"]),
        locationInfo: LocationInfo.fromMap(json["locationInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "uri": uri,
        "fileName": fileName,
        "videoInfo": videoInfo.toMap(),
        "locationInfo": locationInfo.toMap(),
      };
}
