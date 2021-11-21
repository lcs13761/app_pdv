import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:get/get.dart';
import 'package:lustore/app/model/sale.dart';

class RegisterController extends GetxController {
  MoneyMaskedTextController valueCostMonth = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      precision: 2,
      initialValue: 0.0,
      leftSymbol: "R\$ ");
  Sale sale = Sale();


}
