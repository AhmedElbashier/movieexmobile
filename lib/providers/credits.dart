import 'package:flutter/material.dart';

class Credits with ChangeNotifier {
  int id;
  String profilePath;
  int gender;
  String name;
  var popularity;
  int castId;
  var character;

  Credits({
    this.id,
    this.name,
    this.popularity,
    this.profilePath,
    this.gender,
    this.castId,
    this.character,
  });
}
