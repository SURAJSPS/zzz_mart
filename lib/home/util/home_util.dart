import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zzzmart/home/model/banner_model.dart';
import 'package:zzzmart/home/model/category_model.dart';
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/res/global_data.dart';

class HomeUtil {
  static List<BannerModel> bannerList = new List();

  static Future<List<BannerModel>> fetchBanner() async {
    try {
      String url = '${GlobalData.baseUrl}${GlobalData.bannerUrl}';
      print("URL LL  $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATA   $data");
      List<dynamic> list = data['records']
          .map((result) => new BannerModel.fromJson(result))
          .toList();
      bannerList.clear();
      for (int b = 0; b < list.length; b++) {
        BannerModel bannerModel = list[b] as BannerModel;
        bannerList.add(bannerModel);
      }
      return bannerList;
    } catch (e) {
      print("Exception________$e");
      return null;
    }
  }

  static List<CategoryModel> categoryList = new List();

  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      String url = '${GlobalData.baseUrl}${GlobalData.categoryUrl}';
      print("URL LL  $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATA   $data");
      List<dynamic> list = data['data']
          .map((result) => new CategoryModel.fromJson(result))
          .toList();
      categoryList.clear();
      for (int b = 0; b < list.length; b++) {
        CategoryModel categoryModel = list[b] as CategoryModel;
        categoryList.add(categoryModel);
      }
      return categoryList;
    } catch (e) {
      print("Exception________$e");
      return null;
    }
  }

  static List<ProductModel> productList = new List();

  static Future<List<ProductModel>> fetchProducts() async {
    try {
      String url = '${GlobalData.baseUrl}${GlobalData.allProductUrl}';
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
