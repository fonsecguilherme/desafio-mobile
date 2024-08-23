import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gabriel_app/domain/models/video_info.dart';
import 'package:video_player/video_player.dart';

class LocationDetailPage extends StatefulWidget {
  final String videoUrl;
  final VideoInfo info;

  const LocationDetailPage({
    super.key,
    required this.videoUrl,
    required this.info,
  });

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    log(widget.videoUrl);

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {
              _isInitialized = true;
              _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController,
                aspectRatio: 16 / 9,
                autoPlay: true,
                looping: true,
              );
            });
          }).catchError((error) {
            log('Erro ao inicializar o vídeo: $error');
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Imagens',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: const Color.fromARGB(255, 57, 85, 132),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Monitoramento de: ${widget.info.title}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: const Color.fromARGB(255, 57, 85, 132),
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(widget.info.subtitle),
          const SizedBox(height: 32.0),
          Center(
            child: _isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
