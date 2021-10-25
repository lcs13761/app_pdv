import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:LuStore/app/model/product.dart';
class HomeController extends GetxController {
  final store = GetStorage();
  RxList allProduct = [].obs;
  Product product = Product();

  @override
  void onInit() async{
    super.onInit();
    var _response = await product.getAllProducts();
    allProduct.addAll(_response["result"]);
  }

}
