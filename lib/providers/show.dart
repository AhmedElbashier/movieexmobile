import 'package:flutter/material.dart';

class Show with ChangeNotifier {
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
  var voteAverage;
  var runtime;
  int seasonNum;
  int episodeNum;

  Show(
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
      this.voteAverage,
      this.voteCount,
      this.runtime,
      this.seasonNum,
      this.episodeNum});
}
