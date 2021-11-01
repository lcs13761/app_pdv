import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/Api/api_user.dart';
import 'package:lustore/app/model/sale.dart';

class ApiSales extends ApiUser {

  Future<dynamic> getSales() async {
    String token = await refreshJwt();
    final response = await http.get(
      Uri.parse(ApiUser.url + "sale"),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return  jsonDecode(response.body);
    }
  }


  Future<dynamic> create(Sale data) async {
    String token = await refreshJwt();
    final response = await http.post(
      Uri.parse(ApiUser.url + "sale/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> update(Sale sale) async{
    String token = await refreshJwt();
    final response = await http.put(
      Uri.parse(ApiUser.url + "sale/update/" + sale.product.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(sale),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> deleteOne(String id) async {
    String token = await refreshJwt();
    final response = await http.delete(
      Uri.parse(ApiUser.url + "sale/delete/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> deleteAll(Sale data) async {
    String token = await refreshJwt();
    final response = await http.delete(
        Uri.parse(ApiUser.url + "sale/deleteAll"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> finishSale(Sale data) async {
    String token = await refreshJwt();
    final response = await http.post(
        Uri.parse(ApiUser.url + "sale/finalizeSale"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + token
        },
        body: jsonEncode(data)
    );

    if (response.statusCode == 200) {
      return  true;
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

}

