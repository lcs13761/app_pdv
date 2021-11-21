import 'package:lustore/app/api/api_product.dart';
import 'package:lustore/app/core/model.dart';
import 'package:lustore/app/model/category.dart';

class Product extends Model{
    @override
    String action = "product";
    int? id;
    String? code;
    String? product;
    double? saleValue;
    double? costValue;
    String? description;
    String? size;
    int? qts;
    Category? category;
    List? image;

    Product({this.id,this.code, this.product, this.costValue,
      this.saleValue, this.description,
      this.size, this.category,
      this.image,this.qts});

    Product.fromJson(Map<String,dynamic> json):
        id = json["id"],
        code = json["code"],
        product = json["product"],
        saleValue = json["saleValue"],
        costValue = json["costValue"],
        description = json["description"],
        size = json["size"],
        qts = json["qts"],
        image = json["image"],
        category = json["category"];

    Map<String,dynamic> toJson(){
      return {
        "id" : id,
        "code" : code,
        "product" : product,
        "saleValue" : saleValue,
        "costValue" : costValue,
        "description" : description,
        "size" : size,
        "qts" : qts,
        "image" : image,
        "category" : category
      };
    }

}