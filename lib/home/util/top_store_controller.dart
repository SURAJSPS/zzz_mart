import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/home/model/store_model.dart';
import 'package:zzzmart/res/global_data.dart';

class TopStoresController extends GetxController {
  var topStoreModelList = new List<StoreModel>().obs;
  var catStoreModelList = new List<StoreModel>().obs;
  var status = "false".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future fetchTopStores(lat, lng) async {
    status.value = "false";
    print("LL_____________________$lat ___ $lng ");
    Map payload = {
      'latitude': "$lat",
      'longitude': "$lng",
    };

    String url;

    try{
      url =
      "${GlobalData.baseUrl}/admin/ecommerce_api/product/near-location-shop.php?apicall=shop_list";
      // print("SESERRRP $payload");
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
      print("SESERRR1 $payload");
      print("Response Store_______$payload");
      var data;
      print("All Top Stores Data_______$data");

      print("All Top Stores Data_______${response.body}");
      data = jsonDecode(response.body);
      print("All Top Stores Data_______$data");
      topStoreModelList.clear();
      if (data['status'] == "true" && data['data'] != null) {
        List<dynamic> list = data['data']
            .map((result) => new StoreModel.fromJson(result))
            .toList();
        topStoreModelList.clear();
        for (int b = 0; b < list.length; b++) {
          StoreModel storeModel = list[b] as StoreModel;
          topStoreModelList.add(storeModel);
        }
        status.value = data['status'];
        print("All Top Stores Model_______$topStoreModelList");
      } else {
        print("DATA_______$data");
        status.value = data['status'];
      }
    }catch(e){
      print("Exception____ $e");
    }
  }

  Future fetchStoresById(id, lat, lng) async {
    catStoreModelList.clear();
    status.value = "false";
    Map payload = {
      'tcat_id': "$id",
      "latitude": "$lat",
      "longitude": "$lng"
    };

    String url;

    try{
      url =
      "${GlobalData.baseUrl}${GlobalData.storeByCategoryIdUrl}";
      // print("SESERRRP $payload");
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
      print("SESERRR1 $payload");
      print("Response Store_______$payload");
      var data;
      print("All Top Stores Data_______$data");

      print("All Top Stores Data_______${response.body}");
      data = jsonDecode(response.body);
      print("All Top Stores Data_______$data");
      if (data['status'] == "true" && data['data'] != null) {
        List<dynamic> list = data['data']
            .map((result) => new StoreModel.fromJson(result))
            .toList();
        for (int b = 0; b < list.length; b++) {
          StoreModel storeModel = list[b] as StoreModel;
          catStoreModelList.add(storeModel);
        }
        status.value = data['status'];
        print("All Top Stores Model_______$catStoreModelList");
      } else {
        print("DATA_______$data");
        status.value = data['status'];
      }
    }catch(e){
      print("Exception____ $e");
    }
  }
}
