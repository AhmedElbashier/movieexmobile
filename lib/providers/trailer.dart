import 'package:flutter/material.dart';

class Trailer with ChangeNotifier {
  String id;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  String publishedAt;

  Trailer(
      {this.id,
      this.key,
      this.name,
      this.official,
      this.publishedAt,
      this.site,
      this.size,
      this.type});
}
