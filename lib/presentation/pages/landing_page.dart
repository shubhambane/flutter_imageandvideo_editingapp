import 'package:flutter/material.dart';

import '../../core/domain/use_cases/image_use_cases.dart';
import '../../core/domain/use_cases/video_use_cases.dart';
import 'image_editing_page.dart';
import 'video_editing_page.dart';

class LandingPage extends StatelessWidget {
  final ImageUseCases imageUseCases;
  final VideoUseCases videoUseCases;

  const LandingPage({
    super.key,
    required this.imageUseCases,
    required this.videoUseCases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landing Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageEditingPage(
                      imageUseCases: imageUseCases,
                    ),
                  ),
                );
              },
              child: const Text('Image Editing'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoEditingPage(
                      videoUseCases: videoUseCases,
                    ),
                  ),
                );
              },
              child: const Text('Video Editing'),
            ),
          ],
        ),
      ),
    );
  }
}
