import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:lustore/app/api/api_user.dart';
import 'package:http/http.dart' as http;

class ApiUpload extends ApiUser {


  Future<dynamic> upload(String fileName) async {
    String token = await refreshJwt();
    final request =
        http.MultipartRequest('POST', Uri.parse(ApiUser.url + "upload"));
        request.headers.addAll({'Authorization': 'Bearer ' + token});
        request.files.add(http.MultipartFile("image",
        File(fileName).readAsBytes().asStream(), File(fileName).lengthSync(),
        filename: fileName.split("/").last));
    var response = await request.send();
    if (response.statusCode == 200) {
      var _image = await response.stream.transform(utf8.decoder).join();
        _image = _image.replaceAll("\\", "").split(",")[1].split('"')[3];
      return _image;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
