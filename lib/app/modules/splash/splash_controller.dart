import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class SplashController extends GetxController {

  final store = GetStorage();

  @override
  void onInit() async{
    super.onInit();

    await 2.delay();
    if(store.read("remember") != null && store.read("remember") == true){
        Get.offAllNamed("/home");
    }else{
        Get.offAllNamed("/login");
    }

  }


}
