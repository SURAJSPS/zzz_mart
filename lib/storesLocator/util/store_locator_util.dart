import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/storesLocator/model/stores_locator_model.dart';

class StoreLocatorUtil {
  static Set<Marker> markers = {};
  static List<StoreLocatorModel> storesList = new List();

  static Future<List<StoreLocatorModel>> fetchProducts() async {
    try {
      String url = '${GlobalData.baseUrl}${GlobalData.storeLocatorUrl}';
      print("URL LL  $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATA   $data");
      List<dynamic> list = data['data']
          .map((result) => new StoreLocatorModel.fromJson(result))
          .toList();
      storesList.clear();
      for (int b = 0; b < list.length; b++) {
        StoreLocatorModel storeLocatorModel = list[b] as StoreLocatorModel;
        storesList.add(storeLocatorModel);
      }
      return storesList;
    } catch (e) {
      print("Exception________$e");
      return null;
    }
  }
}
