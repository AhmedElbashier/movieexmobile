import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  int id;
  String posterPath;
  String overview;
  String releaseDate;
  String lang;
  String title;
  List genreIds;
  String mediaType;
  String backDropPath;
  var popularity;
  var voteCount;
  bool video;
  var voteAverage;
  int runtime;

  Movie(
      {this.id,
      this.backDropPath,
      this.lang,
      this.mediaType,
      this.genreIds,
      this.title,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.runtime});
}
