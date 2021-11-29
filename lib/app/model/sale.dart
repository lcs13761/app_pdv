import 'package:lustore/app/core/model.dart';
import 'package:lustore/app/model/product.dart';

class Sale extends Model{

  String? client;
  double discount = 0.0;
  Product product = Product();

  Sale(){
    actionApi('sale');
  }

  Sale.fromJson(Map<String,dynamic> json):
        client = json["client"],
        product = json["product"],
        discount = json["discount"];


  Map<String,dynamic> toJson(){
    return {
      "client" : client,
      "product" : product,
      "discount" : discount,
    };
  }
}