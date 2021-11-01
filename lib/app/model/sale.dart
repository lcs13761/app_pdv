import 'package:lustore/app/api/api_sale.dart';
import 'package:lustore/app/model/product.dart';

class Sale extends ApiSales{
  String? client;
  double discount = 0.0;
  Product product = Product();

  Sale();

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