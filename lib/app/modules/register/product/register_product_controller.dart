import 'package:get/get.dart';
import 'package:LuStore/app/model/product.dart';
import 'package:intl/intl.dart';


class RegisterProductController extends GetxController {
    RxBool inLoading = true.obs;
    Product product = Product();
    RxList products = [].obs;
    NumberFormat formatter = NumberFormat.simpleCurrency();


    @override
  void onInit() async{
    super.onInit();
    await getProducts();
  }

  Future getProducts() async{

        var _response = await product.getAllProducts();
        inLoading.value = false;
        products.addAll(_response["result"]);
  }

  Future deleteProduct(_product) async{

    print(_product);
      var _response = await product.delete(_product.toString());
      print(_response);
      return _response;
  }

}
