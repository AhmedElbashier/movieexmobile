import 'package:flutter/material.dart';

class Actor with ChangeNotifier {
  int id;
  String profilePath;
  int gender;
  String name;
  var popularity;
  String birthday;
  String biography;
  String placeOfBirth;

  Actor(
      {this.id,
      this.name,
      this.popularity,
      this.profilePath,
      this.gender,
      this.biography,
      this.birthday,
      this.placeOfBirth});
}
