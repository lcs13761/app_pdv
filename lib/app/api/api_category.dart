import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/api/api_user.dart';
import 'package:lustore/app/model/category.dart';


class ApiCategories extends ApiUser {

  Future<dynamic> getAllCategories() async {
    final response = await http.get(
      Uri.parse(ApiUser.url + "categories"),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> create(Category data) async {
    String token = await refreshJwt();
    final response = await http.post(Uri.parse(ApiUser.url + "category/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> update(Category category) async {
    String token = await refreshJwt();
    final response = await http.put(
      Uri.parse(ApiUser.url + "category/update/" + category.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(category),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> delete(int id) async {
    String token = await refreshJwt();
    final response = await http.delete(
      Uri.parse(ApiUser.url + "category/delete/" + id.toString()),
      headers: <String, String>{'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }
}