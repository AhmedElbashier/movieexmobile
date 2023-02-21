import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieex/providers/genre.dart';

class Genres with ChangeNotifier {
  List<Genre> _movieGenres = [];

  List get movieGenres {
    return [..._movieGenres];
  }

  List<Genre> _showGenres = [];

  List get showGenres {
    return [..._showGenres];
  }

  Future<void> getMovieGenres() async {
    var url =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' genre Success');
        print(responseData);
        List<Genre> newData = [];
        for (var data in responseData['genres']) {
          Genre movies = Genre(id: data['id'], genre: data['name']);
          newData.add(movies);
        }
        _movieGenres = newData;
      } else {
        print('genre error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getShowGenres() async {
    var url =
        'https://api.themoviedb.org/3/genre/tv/list?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' genre Success');
        print(responseData);
        List<Genre> newData = [];
        for (var data in responseData['genres']) {
          Genre movies = Genre(id: data['id'], genre: data['name']);
          newData.add(movies);
        }
        _showGenres = newData;
      } else {
        print('genre error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
