import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lustore/app/api/api_brasil_address.dart';
import 'package:lustore/app/model/address.dart';
import 'package:lustore/app/model/user.dart';

class ConfigUserController extends GetxController {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cep = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController complement = TextEditingController();
  int id = 0;
  int addressId = 0;
  final store = GetStorage();
  User user = User();
  Address address = Address();
  RxString fileImage = ''.obs;
  RxBool onLoadingFinalized = false.obs;
  RxMap errors = {}.obs;

  final count = 0.obs;
  @override
  void onInit() async{
    super.onInit();

    id = store.read('id');
    await dataUser();
    onLoadingFinalized.value = true;
  }

  Future<void> dataUser() async{
      Map _response = await user.show(id);
      name.text = _response['name'];
      email.text = _response['email'];
      cpf.text = _response['cpf'] ?? '';
      phone.text = _response['phone'] ?? '';
      if(_response.containsKey('address').toString().isNotEmpty){
          addressId = _response['address'][0]['id'];
          cep.text = _response['address'][0]['cep'];
          city.text = _response['address'][0]['city'];
          state.text = _response['address'][0]['state'];
          district.text = _response['address'][0]['street'];
          street.text = _response['address'][0]['cep'];
          number.text = _response['address'][0]['number'].toString();
          complement.text = _response['address'][0]['complement'] ?? '';
      }
  }


  Future updateUser() async{


    user.name = name.text;
    user.email = email.text;
    user.cpf = cpf.text;
    user.phone = phone.text;

    if(cep.text.isNotEmpty){
      address.id = addressId > 0 ? addressId : null;
      address.cep = cep.text;
      address.city = city.text;
      address.state = state.text;
      address.district = district.text;
      address.street = street.text;
      address.number = int.tryParse(number.text);
      address.complement = complement.text;
      user.address = address;
    }else{
      user.address = null;
    }

    return await user.update(user, id);

  }

  Future apiCompleteAddress(String _value) async{

    if(_value.toString().contains('-')){
      _value = _value.toString().replaceAll('-', '');
    }

    if(_value.length != 8) return;

    var _response = await addressApiBrazil(_value);
    if(_response == false) return;
    state.text = _response['state'];
    city.text = _response['city'];
    district.text = _response['neighborhood'];
    street.text = _response['street'];

  }
}
