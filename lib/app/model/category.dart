import 'package:lustore/app/api/api_category.dart';
import 'package:lustore/app/core/model.dart';

class Category extends Model{
  @override
  String action = "category";
  int? id;
  String? category;

  Category({this.id,this.category});

  Category.fromJson(Map<String,dynamic> json):
        id = json["id"],
        category = json["category"];

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "category" : category,
    };
  }
}