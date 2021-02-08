import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/home/model/store_model.dart';
import 'package:zzzmart/res/global_data.dart';

class StoreController extends GetxController {
  var itemModelList = new List<ProductModel>().obs;
  var status = "false".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<ProductModel>> fetchItems(id) async {
    status.value = "false";

    Map payload = {
      'stor_id': "$id"
    };

    String url;

    try {
      url = "${GlobalData.baseUrl}${GlobalData.productByStoreIdUrl}";
      print("SESERRRP $payload");
      print("SESERRRP1 $url");
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: payload,
        encoding: Encoding.getByName("utf-8"),
      );

      var data = jsonDecode(response.body);

      if (data['status'] == "true") {
        status.value = data['status'];
        List<dynamic> list = data['data']
            .map((result) => new ProductModel.fromJson(result))
            .toList();
        itemModelList.clear();
        for (int b = 0; b < list.length; b++) {
          ProductModel productModel =
              list[b] as ProductModel;
          itemModelList.add(productModel);
        }
        print("All Stores Products Model_______$itemModelList");
        return itemModelList;
      } else {
        print("DATA_______$data");
        status.value = data['status'];
        return itemModelList;
      }
    } catch (e) {
      status.value = 'false';
      print("Exception I Stores Products_______$e");
      return itemModelList;
    }
  }

  Future<StoreModel> fetchStoreDetails(id) async {
    String url = "${GlobalData.baseUrl}";

    var response = await http.get(url);

    var data = jsonDecode(response.body);
    print("Stores Data_______$data");

    try {
      if (data['status'] == true) {
        List<dynamic> list = data['data']
            .map((result) => new StoreModel.fromJson(result))
            .toList();

        StoreModel storeModel = list[0] as StoreModel;

        print("All Stores Products Model_______$itemModelList");
        return storeModel;
      } else {
        print("DATA_______$data");
        return null;
      }
    } catch (e) {
      print("Exception I Stores Products_______$e");
      return null;
    }
  }
}
