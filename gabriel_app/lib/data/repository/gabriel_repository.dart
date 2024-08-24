import 'dart:io';

import 'package:gabriel_app/data/models/video_model.dart';

import '../http_client.dart';

abstract interface class IGabrielRepository {
  Future<VideoModel?> getAllLocations({String size = '10'});
}

class GabrielRepository extends IGabrielRepository {
  final IHttpClient client;

  GabrielRepository({required this.client});

  @override
  Future<VideoModel?> getAllLocations({String size = '10'}) async {
    final url =
        'http://10.0.2.2:3001/v1/videos/history?limit=$size'; //! para rodar no emulador android
    // final url =
    //     'http://127.0.0.1:3001/v1/videos/history?limit=$size'; //! para rodar no emulador ios
    // final url =
    //     'http://localhost:3001/v1/videos/history?limit=$size'; //! para rodar no browser e testes

    try {
      final response = await client.get(url: url);

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
