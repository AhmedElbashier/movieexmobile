import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Account with ChangeNotifier {
  int id;
  String name;
  String userName;

  Account({this.id, this.name, this.userName});
}

class AccountData with ChangeNotifier {
  Account _details;

  Account get details {
    return _details;
  }

  Future<void> getAccount() async {
    var url =
        'https://api.themoviedb.org/3/account?api_key=4420a385fb4830601c75c6fdd1782136';

    try {
      var response = await http.get(url);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(' images Success');
        print('>>>>>>>>>>>>>>>>');
        print(responseData);
        Account detail = Account(
          id: responseData['id'],
          name: responseData['name'],
          userName: responseData['username'],
        );
        _details = detail;
      } else {
        print('account error');
        print(responseData);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
