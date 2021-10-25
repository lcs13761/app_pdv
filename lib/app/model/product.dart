import 'package:LuStore/app/api/api_product.dart';
import 'package:LuStore/app/model/category.dart';
import 'package:LuStore/app/model/image_controller.dart';

class Product extends ApiProduct{

    String? code;
    String? product;
    double? saleValue;
    double? costValue;
    String? description;
    String? size;
    int? qts;
    Category? category;
    List? image;

    Product({this.code, this.product, this.costValue,
      this.saleValue, this.description,
      this.size, this.category,
      this.image,this.qts});

    Product.fromJson(Map<String,dynamic> json):
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