import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieex/providers/actor.dart';
import 'package:http/http.dart' as http;

class ActorDetails with ChangeNotifier {
  Actor _actor;

  Actor get actorDetails {
    return _actor;
  }

  Future<void> getActorDetails(pId) async {
    var url =
        'https://api.themoviedb.org/3/person/$pId?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' actor Success');
        print(responseData);
        Actor data = Actor(
            id: responseData['id'],
            name: responseData['name'],
            gender: responseData['gender'],
            biography: responseData['biography'],
            birthday: responseData['birthday'],
            placeOfBirth: responseData['place_of_birth'],
            popularity: responseData['popularity'],
            profilePath: responseData['profile_path']);

        _actor = data;
      } else {
        print('actor details error');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
