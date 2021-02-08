import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/res/global_data.dart';

class CategoryUtil {
  static List<ProductModel> productList = new List();

  static Future<List<ProductModel>> fetchProducts(id) async {
    try {
      String url =
          '${GlobalData.baseUrl}${GlobalData.allProductByCategoryUrl}$id';
      print("URL LL  $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATA   $data");
      List<dynamic> list = data['data']
          .map((result) => new ProductModel.fromJson(result))
          .toList();
      productList.clear();
      for (int b = 0; b < list.length; b++) {
        ProductModel productModel = list[b] as ProductModel;
        productList.add(productModel);
      }
      return productList;
    } catch (e) {
      print("Exception________$e");
      return null;
    }
  }
}
