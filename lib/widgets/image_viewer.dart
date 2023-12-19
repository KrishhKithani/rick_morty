import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({required this.url, super.key});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Image.network(url, fit: BoxFit.fill,
        errorBuilder: (context, error, stacktrace) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed to load image ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        int progress = ((loadingProgress.cumulativeBytesLoaded /
                (loadingProgress.expectedTotalBytes ?? 1) *
                100))
            .toInt();
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Text(
                '${progress.toString()} % Loaded',
                style: const TextStyle(fontSize: 14, color: Colors.white60),
              )
            ],
          ),
        );
      }
    });
  }
}
