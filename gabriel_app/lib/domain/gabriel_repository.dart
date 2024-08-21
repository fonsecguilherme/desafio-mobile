import 'dart:io';

import 'package:gabriel_app/domain/models/video_model.dart';
import 'package:http/http.dart' as http;

abstract interface class IGabrielRepository {
  Future<VideoModel?> getAllLocations({String size = '10'});
}

class GabrielRepository extends IGabrielRepository {
  @override
  Future<VideoModel?> getAllLocations({String size = '10'}) async {
    final url = 'http://127.0.0.1:3001/v1/videos/history?limit=$size';

    try {
      final response = await http.get(Uri.parse(url));

      switch (response.statusCode) {
        case HttpStatus.accepted:
          final result = VideoModel.fromJson(response.body);

          return result;

        case HttpStatus.badRequest:
          throw Exception('Bad request: ${response.statusCode}');

        case HttpStatus.notFound:
          throw Exception('Failed to find the url. ${response.statusCode}');

        default:
          throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
