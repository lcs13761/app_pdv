import 'package:get/get.dart';
import 'package:lustore/app/model/product.dart';
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
        inLoading.value = true;
        products.clear();
        var _response = await product.getAllProducts();
        inLoading.value = false;
        products.addAll(_response["result"]);
  }

  Future deleteProduct(_id) async{

    return await product.delete(_id.toString());

  }

}
