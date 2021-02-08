import 'package:get/get.dart';
import 'package:zzzmart/address/model/address_model.dart';

class AddressController extends GetxController {
  var currentAddressIndex = "".obs;
  var addressObjectList = new List<AddressModel>().obs;

  updateAddressIndex(index) {
    currentAddressIndex = index;
  }
}
