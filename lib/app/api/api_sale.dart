import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/api/api_auth.dart';
import 'package:lustore/app/model/sale.dart';
import 'package:lustore/app/boot/config.dart';

class ApiSales  {


  ApiAuth user = ApiAuth();

  Future<dynamic> getSales() async {
    String token = await user.refreshJwt();
    final response = await http.get(
      Uri.parse(url + "sale"),
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
    String token = await user.refreshJwt();
    final response = await http.post(
      Uri.parse(url + "sale/add"),
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
    String token = await user.refreshJwt();
    final response = await http.put(
      Uri.parse(url + "sale/update/" + sale.product.id.toString()),
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
    String token = await user.refreshJwt();
    final response = await http.delete(
      Uri.parse(url + "sale/delete/" + id),
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
    String token = await user.refreshJwt();
    final response = await http.delete(
        Uri.parse(url + "sale/deleteAll"),
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
    String token = await user.refreshJwt();
    final response = await http.post(
        Uri.parse(url + "sale/finalizeSale"),
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

  Future<dynamic> costMonth(Map data) async {
    String token = await user.refreshJwt();
    final response = await http.post(
        Uri.parse(url + "monthCost/add"),
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

