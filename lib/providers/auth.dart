import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  var _token;
  var _sessId;
  var _accId;

  int get accId {
    return _accId;
  }

  Future<void> getToken() async {
    var url =
        'https://api.themoviedb.org/3/authentication/token/new?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        print(' token Success');
        print(responseData);
        _token = responseData['request_token'];
        postSession(_token);
      } else {
        print('token error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> getAccId(sessId) async {
    var url =
        'https://api.themoviedb.org/3/account?api_key=4420a385fb4830601c75c6fdd1782136&session_id=$sessId';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        print(' acc Success');
        print(responseData);
        _accId = responseData['id'];
      } else {
        print('acc error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> postSession(token) async {
    var url =
        'https://api.themoviedb.org/3/authentication/session/new?api_key=4420a385fb4830601c75c6fdd1782136';

    Map map = {"request_token": token};
    try {
      var response = await http.post(url, body: map);
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        print(' session Success');
        print(responseData);
        _sessId = responseData['session_id'];
        getAccId(_sessId);
      } else {
        print('session error');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
