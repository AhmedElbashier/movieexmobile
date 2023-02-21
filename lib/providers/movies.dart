import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieex/providers/credits.dart';
import 'package:movieex/providers/image.dart';
import 'package:movieex/providers/movie.dart';
import 'package:movieex/providers/trailer.dart';

class Movies with ChangeNotifier {
  List<Movie> _trendList = [];

  List get trendList {
    return [..._trendList];
  }

  List<Movie> _popList = [];

  List get popList {
    return [..._popList];
  }

  List<Movie> _upcoming = [];

  List get upcoming {
    return [..._upcoming];
  }

  List<Movie> _topRatedList = [];

  List get topRatedList {
    return [..._topRatedList];
  }

  List<Trailer> _trailers = [];

  List get trailers {
    return [..._trailers];
  }

  List<Movie> _searchList = [];

  List get searchList {
    return [..._searchList];
  }

  List<Movie> _similarMList = [];

  List get similarMList {
    return [..._similarMList];
  }

  List<Movie> _newM = [];

  List get newM {
    return [..._newM];
  }

  List<Credits> _mCredits = [];

  List get mCredits {
    return [..._mCredits];
  }

  List<MovieImages> _mImages = [];

  List get mImages {
    return [..._mImages];
  }

  List<Movie> _actorMovies = [];

  List get actorMovies {
    return [..._actorMovies];
  }

  Movie _detailsMovies;

  Movie get detailsMovies {
    return _detailsMovies;
  }

  List<Movie> findBy(genreId) {
    var list = _trendList
        .where((element) => element.genreIds.contains(genreId))
        .toList();
    return list;
  }

  Future<void> trendingMovies(page) async {
    var url =
        'https://api.themoviedb.org/3/trending/movie/week?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
        }
        _trendList = newData;
        _newM.addAll(_trendList);
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> popularMovies(page) async {
    var url =
        'https://api.themoviedb.org/3/movie/popular?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
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

  Future<void> upcomingMovies(page) async {
    var url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
        }
        _upcoming = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> topRatedMovies(page) async {
    var url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=4420a385fb4830601c75c6fdd1782136&page=$page';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' trending Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
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

  Future<void> getMovieDetails(mId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$mId?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' details Success');
        print(responseData);
        Movie movies = Movie(
            id: responseData['id'],
            title: responseData['title'],
            overview: responseData['overview'],
            backDropPath: responseData['backdrop_path'],
            lang: responseData['original_language'],
            genreIds: responseData['genres'],
            mediaType: responseData['media_type'],
            popularity: responseData['popularity'],
            posterPath: responseData['poster_path'],
            releaseDate: responseData['release_date'],
            video: responseData['video'],
            voteAverage: responseData['vote_average'],
            voteCount: responseData['vote_count'],
            runtime: responseData['runtime']);

        _detailsMovies = movies;
      } else {
        print('details error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> geTrailer(mId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$mId/videos?api_key=4420a385fb4830601c75c6fdd1782136';

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

  Future<void> searchMovie(query) async {
    var url =
        'https://api.themoviedb.org/3/search/movie?api_key=4420a385fb4830601c75c6fdd1782136&query=$query';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' search Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
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

  Future<void> getMovieCredits(mId) async {
    var url =
        'https://api.themoviedb.org/3//movie/$mId/credits?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' credits Success');
        print(responseData);
        List<Credits> newData = [];
        for (var data in responseData['cast']) {
          Credits movies = Credits(
            id: data['id'],
            name: data['name'],
            castId: data['cast_id'],
            character: data['character'],
            gender: data['gender'],
            popularity: data['popularity'],
            profilePath: data['profile_path'],
          );
          newData.add(movies);
        }
        _mCredits = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getMovieImages(mId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$mId/images?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' images Success');
        print(responseData);
        List<MovieImages> newData = [];
        for (var data in responseData['backdrops']) {
          MovieImages movies = MovieImages(
            height: data['height'],
            filePath: data['file_path'],
            width: data['width'],
          );
          newData.add(movies);
        }
        _mImages = newData;
      } else {
        print('trending error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getSimilerMovies(mId) async {
    var url =
        'https://api.themoviedb.org/3/movie/$mId/similar?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' images Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['results']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
        }
        _similarMList = newData;
      } else {
        print('images error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getActorMovies(pId) async {
    var url =
        'https://api.themoviedb.org/3/person/$pId/movie_credits?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' actor movies Success');
        print(responseData);
        List<Movie> newData = [];
        for (var data in responseData['cast']) {
          Movie movies = Movie(
            id: data['id'],
            title: data['title'],
            overview: data['overview'],
            backDropPath: data['backdrop_path'],
            lang: data['original_language'],
            genreIds: data['genre_ids'],
            mediaType: data['media_type'],
            popularity: data['popularity'],
            posterPath: data['poster_path'],
            releaseDate: data['release_date'],
            video: data['video'],
            voteAverage: data['vote_average'],
            voteCount: data['vote_count'],
          );
          newData.add(movies);
        }
        _actorMovies = newData;
      } else {
        print('actor movies error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
