import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieex/providers/credits.dart';
import 'package:movieex/providers/image.dart';
import 'package:movieex/providers/movie.dart';
import 'package:movieex/providers/show.dart';
import 'package:movieex/providers/trailer.dart';

class Shows with ChangeNotifier {
  List<Show> _trendList = [];

  List get trendList {
    return [..._trendList];
  }

  List<Show> _popList = [];

  List get popList {
    return [..._popList];
  }

  List<Trailer> _trailers = [];

  List get trailers {
    return [..._trailers];
  }

  List<Show> _topRatedList = [];

  List get topRatedList {
    return [..._topRatedList];
  }

  List<Show> _similarShList = [];

  List get similarShList {
    return [..._similarShList];
  }

  List<Show> _searchList = [];

  List get searchList {
    return [..._searchList];
  }

  List<Credits> _shCredits = [];

  List get shCredits {
    return [..._shCredits];
  }

  List<MovieImages> _shImages = [];

  List get shImages {
    return [..._shImages];
  }

  Show _detailsShows;

  Show get detailsShows {
    return _detailsShows;
  }

  List<Show> _actorShows = [];

  List get actorShows {
    return [..._actorShows];
  }

  List<Show> findBy(genreId) {
    var list = _trendList
        .where((element) => element.genreIds.contains(genreId))
        .toList();
    return list;
  }

  Future<void> geTrailer(shId) async {
    var url =
        'https://api.themoviedb.org/3/tv/$shId/videos?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trailers Success');
        print(responseData);
        List<Trailer> newData = [];
        for (var data in responseData['results']) {
          Trailer movies = Trailer(
            id: data['id'],
            key: data['key'],
            name: data['name'],
            official: data['official'],
            publishedAt: data['published_at'],
            site: data['site'],
            size: data['size'],
            type: data['type'],
          );
          newData.add(movies);
        }
        _trailers = newData;
      } else {
        print('trailers error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> trendingShows(page) async {
    var url =
        'https://api.themoviedb.org/3/trending/tv/week?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['results']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            // video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _trendList = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> popularShows(page) async {
    var url =
        'https://api.themoviedb.org/3/tv/popular?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['results']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _popList = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> topRatedShows(page) async {
    var url =
        'https://api.themoviedb.org/3/tv/top_rated?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['results']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _topRatedList = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getShowCredits(mId) async {
    var url =
        'https://api.themoviedb.org/3//tv/$mId/credits?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' credits Success');
        print(responseData);
        List<Credits> newData = [];
        for (var data in responseData['cast']) {
          Credits shows = Credits(
            id: data['id'],
            name: data['name'],
            castId: data['cast_id'],
            character: data['character'],
            gender: data['gender'],
            popularity: data['popularity'],
            profilePath: data['profile_path'],
          );
          newData.add(shows);
        }
        _shCredits = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getShowImages(mId) async {
    var url =
        'https://api.themoviedb.org/3/tv/$mId/images?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' images Success');
        print(responseData);
        List<MovieImages> newData = [];
        for (var data in responseData['backdrops']) {
          MovieImages shows = MovieImages(
            height: data['height'],
            filePath: data['file_path'],
            width: data['width'],
          );
          newData.add(shows);
        }
        _shImages = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getSimilerShows(shId) async {
    var url =
        'https://api.themoviedb.org/3/tv/$shId/similar?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' images Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['results']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _similarShList = newData;
      } else {
        print('images error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getShowsDetails(shId) async {
    var url =
        'https://api.themoviedb.org/3/tv/$shId?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' details Success');
        print(responseData);
        Show shows = Show(
            id: responseData['id'],
            title: responseData['title'],
            overview: responseData['overview'],
            backDropPath: responseData['backdrop_path'],
            lang: responseData['original_language'],
            genreIds: responseData['genres'],
            mediaType: responseData['media_type'],
            popularity: responseData['popularity'],
            posterPath: responseData['poster_path'],
            releaseDate: responseData['first_air_date'],
            voteAverage: responseData['vote_average'],
            voteCount: responseData['vote_count'],
            runtime: responseData['runtime'],
            episodeNum: responseData['number_of_episodes'],
            seasonNum: responseData['number_of_seasons']);

        _detailsShows = shows;
      } else {
        print('details error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> searchShow(query) async {
    var url =
        'https://api.themoviedb.org/3/search/tv?api_key=4420a385fb4830601c75c6fdd1782136&query=$query';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' search Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['results']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _searchList = newData;
      } else {
        print('search error');
        print(response.statusCode);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getActorShows(pId) async {
    var url =
        'https://api.themoviedb.org/3/person/$pId/tv_credits?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' actor shows Success');
        print(responseData);
        List<Show> newData = [];
        for (var data in responseData['cast']) {
          Show shows = Show(
            id: data['id'],
            title: data['name'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['first_air_date'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(shows);
        }
        _actorShows = newData;
      } else {
        print('actor Shows error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
