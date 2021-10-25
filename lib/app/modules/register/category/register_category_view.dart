import 'package:flutter/material.dart';
import 'package:LuStore/app/theme/loading_style.dart';
import 'package:get/get.dart';
import 'register_category_controller.dart';
import 'package:LuStore/app/routes/app_pages.dart';

class RegisterCategoryView extends GetView<RegisterCategoryController> {
  const RegisterCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: backgroundColorLogo,
        title: const Text('Cadastro de categorias',  style: styleColorDark,),
      ),
      floatingActionButton: floatingButton(),
      body: categories(),
    );
  }

  Widget categories() {
    return Obx(() {
      if (controller.inLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
            color: styleColorBlue,
          ),
        );
      }
      return ListView.separated(
        separatorBuilder: (context, index) =>
        const Divider(
          color: whiteConstColor,
          height: 1,
        ),
        itemCount: controller.categories.length,
        itemBuilder: (BuildContext context, int index) {
          var _category = controller.categories[index];
          return ListTile(
            onLongPress: () {
              dialogActionProduct(context, _category["id_product"], index);
            },
            onTap: () {

            },
            title: product(_category),
          );
        },
      );
    });
  }

  void dialogActionProduct(context, _category, index) {
    Get.dialog(AlertDialog(
      content: ListTile(
        onTap: () {
          Get.back();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  content: const Text("Deseja realmente excluir o produto ?"),
                  actions: [
                    ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "NÃO", style: TextStyle(color: Colors.black),)),
                    ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
                        onPressed: () async{
                          // loading(context);
                          // await 1.delay();
                          // var _response = await controller.deleteProduct(_product);
                          // if(_response != true){
                          //   Get.back();
                          //   Get.back();
                          //   error(context, _response["error"].toString());
                          // }else{
                          //   Get.back();
                          //   Get.back();
                          //   controller.products.removeAt(index);
                          // }
                        },
                        child: const Text("SIM"))
                  ],
                );
              }
          );
        },
        title: Text("Excluir Categoria."),
      ),
    ));
  }

  Widget product(_product) {
    return Row(
      children: <Widget>[
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color.fromRGBO(31, 31, 31, 1.0),
          ),
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: _product["image"] != null
              ? Image.network(
            _product["image"],
            fit: BoxFit.fill,
          )
              : const Align(
            alignment: Alignment.center,
            child: Text("sa", style: colorAndSizeRegisterProduct),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                _product["qts"].toString(),
                style: colorAndSizeRegisterProduct,
              ),
            ),
            subtitle: Text(
              _product["product"],
              style: colorAndSizeRegisterProduct,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(controller.formatter.format(_product["saleValue"]),
              style: colorAndSizeRegisterProduct),
        ),
      ],
    );
  }

  Widget floatingButton() {
    return FloatingActionButton(
      onPressed: () {

      },
      child: const Icon(Icons.add, color: whiteConstColor),
      backgroundColor: styleColorBlue,
    );
  }
}
