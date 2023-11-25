import 'package:flutter/material.dart';
import 'core/data/repositories/image_repository.dart';
import 'core/data/repositories/repository.dart';
import 'core/data/repositories/video_repository.dart';
import 'core/domain/use_cases/image_use_cases.dart';
import 'core/domain/use_cases/video_use_cases.dart';
import 'presentation/pages/landing_page.dart';

class MyApp extends StatelessWidget {
  late final Repository imageRepository;
  late final Repository videoRepository;

  late final ImageUseCases imageUseCases;
  late final VideoUseCases videoUseCases;

  MyApp({super.key}) {
    imageRepository = ImageRepository();
    videoRepository = VideoRepository();
    imageUseCases = ImageUseCases(imageRepository);
    videoUseCases = VideoUseCases(videoRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Editing App',
      home: LandingPage(
        imageUseCases: imageUseCases,
        videoUseCases: videoUseCases,
      ),
    );
  }
}
