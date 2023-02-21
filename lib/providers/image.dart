import 'package:flutter/material.dart';

class MovieImages with ChangeNotifier {
  String filePath;
  int height;
  int width;

  MovieImages({
    this.height,
    this.filePath,
    this.width,
  });
}
