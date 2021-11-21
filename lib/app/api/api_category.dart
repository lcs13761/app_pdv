import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/api/api_auth.dart';
import 'package:lustore/app/model/category.dart';
import 'package:lustore/app/boot/config.dart';
import 'package:lustore/app/repository/iapi_action.dart';


class ApiCategories implements IApiAction{

  ApiAuth user = ApiAuth();



  @override
  Future index() async{
    final response = await http.get(
      Uri.parse(url + "category"),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future show(id) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future store(data) async{
    String token = await user.refreshJwt();
    final response = await http.post(Uri.parse(url + "category/register"),
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

  @override
  Future update(data, id) async{
    String token = await user.refreshJwt();
    final response = await http.put(
      Uri.parse(url + "category/update/" + data.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }

  @override
  Future destroy(id) async{
    String token = await user.refreshJwt();
    final response = await http.delete(
      Uri.parse(url + "category/delete/" + id.toString()),
      headers: <String, String>{'Authorization': 'Bearer ' + token},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return jsonDecode(response.body);
    }
  }
}