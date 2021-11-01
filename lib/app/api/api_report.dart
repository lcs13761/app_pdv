import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/Api/api_user.dart';


class ApiReport extends ApiUser {

  Future<dynamic> getReportsSales() async {
    String token = await refreshJwt();
    final response = await http.get(
      Uri.parse(ApiUser.url + "reports/sales"),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> getReportsCost() async {
    String token = await refreshJwt();
    final response = await http.get(
      Uri.parse(ApiUser.url +  "reports/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(jsonEncode(response.body));
    }
  }

  Future<dynamic> getCategoriesAndProductsBestSelling() async {
    String token = await refreshJwt();
    final response = await http.get(
      Uri.parse(ApiUser.url +  "reports/best/category/product"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<dynamic> annualProfit() async {
    String token = await refreshJwt();
    final response = await http.get(
      Uri.parse(ApiUser.url + "reports/annual-profit"),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }
}