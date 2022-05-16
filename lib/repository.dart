import 'dart:convert';

import 'package:bljr_api_flutter/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://62812ad21020d85205864927.mockapi.io/users';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Blog> blog = it.map((e) => Blog.fromJson(e)).toList();
        return blog;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String name, String gender) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/users'),
          body: {"name": name, "gender": gender});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String name, String gender) async {
    try {
      final response = await http.put(
          Uri.parse(_baseUrl + '/users' + id.toString()),
          body: {'name': name, 'gender': gender});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + id));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
