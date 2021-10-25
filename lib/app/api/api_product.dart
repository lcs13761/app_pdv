import 'package:LuStore/app/api/api_user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:LuStore/app/model/product.dart';

class ApiProduct extends ApiUser{

  Future<dynamic> getOneProduct(String code) async{
    final response = await http.get(
      Uri.parse(ApiUser.url + "product/" + code),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> getAllProducts() async{
    final response = await http.get(
      Uri.parse(ApiUser.url + "products"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> create(Product data) async{
    String token = await refreshJwt();
    final response = await http.post(
      Uri.parse(ApiUser.url + "product/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> update(Product data,id) async{
    String token = await refreshJwt();
    final response = await http.put(
      Uri.parse(ApiUser.url + "product/update/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> delete(String id) async{
    String token = await refreshJwt();
    final response = await http.delete(
      Uri.parse(ApiUser.url + "product/delete/" + id),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

}